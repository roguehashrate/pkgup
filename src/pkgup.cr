require "process"

module Pkgup
  RED    = "\e[31m"
  GREEN  = "\e[32m"
  BLUE   = "\e[34m"
  YELLOW = "\e[33m"
  RESET  = "\e[0m"

  VERSION = "0.1.0"

  def self.run
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

    print "#{BLUE}Would you like to update [sys]pkgs, [flatpak]pkgs, or [both]: #{RESET}"
    user_choice = gets.to_s.strip.downcase

    case user_choice
    when "sys"
      puts "#{YELLOW}Updating System Programs...#{RESET}"
      system("#{auth_cmd} #{pkg_man} update && #{auth_cmd} #{pkg_man} upgrade -y")
      puts "#{GREEN}System update complete!#{RESET}"
    when "flatpak"
      puts "#{YELLOW}Updating Flatpak Programs...#{RESET}"
      system("flatpak update -y")
      puts "#{GREEN}Flatpak update complete!#{RESET}"
    when "both"
      puts "#{YELLOW}Updating System and Flatpak Programs...#{RESET}"
      system("#{auth_cmd} #{pkg_man} update && #{auth_cmd} #{pkg_man} upgrade -y")
      system("flatpak update -y")
      puts "#{GREEN}All updates complete!#{RESET}"
    else
      puts "#{RED}Invalid option. Please enter 'sys', 'flatpak', or 'both'.#{RESET}"
    end
  end
end

Pkgup.run