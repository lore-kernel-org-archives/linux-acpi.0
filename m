From: Tomi Kallio <tomi@sllpilots.fi>
Subject: Radeon M7 and resuming from suspend-to-ram
Date: Fri, 14 Jan 2005 16:12:04 +0200
Message-ID: <41E7D334.6060003@sllpilots.fi>
Reply-To: gentoo-user@lists.gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <gentoo-user-return-99261-lnx-gentoo-user=m.gmane.org@lists.gentoo.org>
List-Post: <mailto:gentoo-user@gentoo.org>
List-Help: <mailto:gentoo-user-help@gentoo.org>
List-Unsubscribe: <mailto:gentoo-user-unsubscribe@gentoo.org>
List-Subscribe: <mailto:gentoo-user-subscribe@gentoo.org>
To: gentoo-user@lists.gentoo.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hello.

I'm running gentoo on Compaq Evo N800V laptop with radeon M7. At the 
moment I'm using gentoo-dev-sources version 2.6.10-r4. For the first 
time suspend-to-ram almoust works but I'm having trouble resuming 
radeon/screen. After resuming, display on laptop stays black with just 
"weak" backlight but if I plug in external monitor, then external 
monitor is working normally but laptop's display stays black. So the 
resume from X "works". If I switch to console then external monitor 
complaints about invalid mode while laptop's display stays black. With 
radeontool I can normally power down/up external output, but display on 
laptop stays blank no matter what I do. I have also tried boot-radeon in 
console that should reset video bios, but it doesn't work either.

Any ideas?

Tomi

--
gentoo-user@gentoo.org mailing list
