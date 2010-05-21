From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Device enumeration at boot doesn't detect acpi battery.
Date: Fri, 21 May 2010 08:58:33 +0800
Message-ID: <1274403513.22924.5435.camel@rzhang1-desktop>
References: <77056.54759.qm@web65511.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27553 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755019Ab0EUA57 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 May 2010 20:57:59 -0400
In-Reply-To: <77056.54759.qm@web65511.mail.ac4.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian Hutsell <bhut_ooto@yahoo.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Brian,

please attach the acpidump output of your laptop.
please attach the dmesg output after boot.
It would be great if you can file a new bug report at
https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach these info there.

thanks,
rui


On Thu, 2010-05-20 at 18:50 +0800, Brian Hutsell wrote:
> Hello,
> 
> Apologies in 
> advance if I sent this to the wrong place.  I'm not sure where the 
> kernel's boot-time device enumeration code lives.  If this is the wrong 
> forum, could someone please tell me the email address I should forward 
> it to?  Thanks.
> 
> I have a laptop running Linux 2.6.32-22-generic 
> #33-Ubuntu SMP x86_64.  My laptop is an ACER Aspire 6930.  When I boot, 
> the battery isn't enumerated into "sysfs" like gnome-power-manager 
> expects it to.
> 
> After boot, the following command finds nothing:
> % find /sys -name "BAT1" -print
> 
> If I inspect the contents of one 
> of the files in the /proc/acpi/battery/BAT1 directory, they'll appear:
> %  cat /proc/acpi/battery/BAT1/state 
> present:                 yes
> capacity state:          ok
> charging state:          charged
> present rate:            0 mA
> remaining 
> capacity:      3619 mAh
> present voltage:         12131 mV
> 
> % 
> find /sys -name "BAT1" -print
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1
> /sys/class/power_supply/BAT1
> 
> This is repeatable on every boot.  Once I "cat 
> /proc/acpi/battery/BAT1/state", gnome-power-manager recognizes my 
> battery (via upowerd) and all is well.
> 
> This is the 
> non-"gnome-power-manager" part of https://bugzilla.gnome.org/show_bug.cgi?id=617529
> 
> 
> Can someone point me at the right forum, the code that needs to be 
> modified, or better yet, fix the problem?  I've never touched with the 
> kernel code before.
> 
> All help is appreciated.
> --Brian
> 
> 
>       
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


