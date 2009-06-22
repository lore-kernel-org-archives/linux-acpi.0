From: Patrick Voegeli Olivera <patrick.voegeli@gmail.com>
Subject: Sata link_power_management_policy questions
Date: Mon, 22 Jun 2009 20:50:09 +0200
Message-ID: <4A3FD261.7060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:37789 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZFVSuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 14:50:17 -0400
Received: by ewy6 with SMTP id 6so4943890ewy.37
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2009 11:50:18 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi there,

I have a laptop with Sata set to native mode and ahci enabled in the 
bios. In ubuntu, I can see 
/sys/class/scsi_host/host0/link_power_management_policy for host0, host1 
and host2, but if I read any of those using cat they always will return 
max_performance, even if I echo min_power or medium_power and it gives 
no errors:

root@patrick-laptop:~# cat 
/sys/class/scsi_host/host0/link_power_management_policy
max_performance
root@patrick-laptop:~# echo min_power > 
/sys/class/scsi_host/host0/link_power_management_policy
root@patrick-laptop:~# cat 
/sys/class/scsi_host/host0/link_power_management_policy
max_performance

I've tried to look around for a solution, but I haven't found anything 
useful. Is this a feature that depends on the HDD? Does the hard drive 
need to be sata 2/300 or should it also work with sata 1/150? Is it just 
that my laptop doesn't support it?

Since my HDD is sata150, I've tried with another HDD and I had the same 
problem. I don't know if it was sata2 compliant, though.

My laptop has intel chipsets. Namely, the 965gm (with x3100 graphics) 
northbridge and I think it has a ich8 southbridge.

Any ideas on what to try?

# lspci
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory 
Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 
Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 
Integrated Graphics Controller (rev 03)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #4 (rev 03)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #5 (rev 03)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
Controller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 3 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
Controller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3)
00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface 
Controller (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) 
IDE Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) 
SATA AHCI Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller 
(rev 03)
04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8055 PCI-E 
Gigabit Ethernet Controller (rev 14)
06:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
[Golan] Network Connection (rev 02)

Thanks, any input will be welcome.
