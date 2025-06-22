require "process"

module Pkgup
  RED    = "\e[31m"
  GREEN  = "\e[32m"
  BLUE   = "\e[34m"
  YELLOW = "\e[33m"
  RESET  = "\e[0m"

  VERSION = "0.1.0"

  def self.update_sys(auth_cmd : String, pkg_man : String)
    system("#{auth_cmd} #{pkg_man} update && #{auth_cmd} #{pkg_man} upgrade -y")
    puts "#{GREEN}System package update complete!#{RESET}"
  end

  def self.update_flat
      system("flatpak update -y")
      puts "#{GREEN}Flatpak update complete!#{RESET}"
  end

  def self.run
    
      if ARGV.includes?("--version") || ARGV.includes?("-v")
    puts "Pkgup version #{VERSION}"
    exit
  elsif ARGV.includes?("--help") || ARGV.includes?("-h")
    puts <<-HELP
    Usage: pkgup [option]
      sys      Update system packages
      flat     Update Flatpak packages
      both     Update both system and Flatpak
      -v       Show version
      -h       Show help
    HELP
    exit
  end

    auth_cmd = if system("which doas > /dev/null 2>&1")
      "doas"
    else
      "sudo"
    end

    pkg_man = if system("which nala > /dev/null 2>&1")
      "nala"
    else
      "apt"
    end

    user_choice = ARGV[0]?.try(&.strip.downcase)

    if user_choice.nil? || user_choice.empty?
      print "#{BLUE}Would you like to update [sys] pkgs, [flat]pak pkgs, or [both]: #{RESET}"
      user_choice = gets.try(&.strip.downcase) || ""
    end
    
    case user_choice
    when "sys"
      puts "#{YELLOW}Updating System Programs...#{RESET}"
      update_sys(auth_cmd, pkg_man)
    when "flat"
      puts "#{YELLOW}Updating Flatpak Programs...#{RESET}"
      update_flat
    when "both"
      puts "#{YELLOW}Updating System and Flatpak Programs...#{RESET}"
      update_sys(auth_cmd, pkg_man)
      update_flat
      puts "#{GREEN}All updates complete!#{RESET}"
    else
      puts "#{RED}Invalid option. Please enter 'sys', 'flatpak', or 'both'.#{RESET}"
    end
  end
end

Pkgup.run