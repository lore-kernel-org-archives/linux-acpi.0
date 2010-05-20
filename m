From: Brian Hutsell <bhut_ooto@yahoo.com>
Subject: Device enumeration at boot doesn't detect acpi battery.
Date: Thu, 20 May 2010 03:50:07 -0700 (PDT)
Message-ID: <77056.54759.qm@web65511.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from n11.bullet.mail.ac4.yahoo.com ([74.6.228.83]:21016 "HELO
	n11.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751153Ab0ETKuK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 May 2010 06:50:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

Apologies in 
advance if I sent this to the wrong place.  I'm not sure where the 
kernel's boot-time device enumeration code lives.  If this is the wrong 
forum, could someone please tell me the email address I should forward 
it to?  Thanks.

I have a laptop running Linux 2.6.32-22-generic 
#33-Ubuntu SMP x86_64.  My laptop is an ACER Aspire 6930.  When I boot, 
the battery isn't enumerated into "sysfs" like gnome-power-manager 
expects it to.

After boot, the following command finds nothing:
% find /sys -name "BAT1" -print

If I inspect the contents of one 
of the files in the /proc/acpi/battery/BAT1 directory, they'll appear:
%  cat /proc/acpi/battery/BAT1/state 
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining 
capacity:      3619 mAh
present voltage:         12131 mV

% 
find /sys -name "BAT1" -print
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1
/sys/class/power_supply/BAT1

This is repeatable on every boot.  Once I "cat 
/proc/acpi/battery/BAT1/state", gnome-power-manager recognizes my 
battery (via upowerd) and all is well.

This is the 
non-"gnome-power-manager" part of https://bugzilla.gnome.org/show_bug.cgi?id=617529


Can someone point me at the right forum, the code that needs to be 
modified, or better yet, fix the problem?  I've never touched with the 
kernel code before.

All help is appreciated.
--Brian


      

