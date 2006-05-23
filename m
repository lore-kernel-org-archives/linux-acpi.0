From: Andreas Saur <saur@acmelabs.de>
Subject: Double/Tripple lan0 entries in /proc/interrupts
Date: Tue, 23 May 2006 22:45:36 +0000
Message-ID: <44739090.9080807@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nattrymon.rzone.de ([81.169.145.178]:29393 "EHLO
	nattrymon.rzone.de") by vger.kernel.org with ESMTP id S932261AbWEWWpj
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 May 2006 18:45:39 -0400
Received: from server.zuhause.xx (p50814C7D.dip0.t-ipconnect.de [80.129.76.125])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k4NMjaSF008179
	for <linux-acpi@vger.kernel.org>; Wed, 24 May 2006 00:45:37 +0200 (MEST)
Received: from [192.168.1.38] (helo=[192.168.1.38])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1Fict7-0003Ld-T2
	for linux-acpi@vger.kernel.org; Tue, 23 May 2006 21:49:53 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello All,

after getting kernel panics with the mm-patches, I've just patched the 
kernel 2.6.17-rc4 only with the latest appropriate git-acpi patch.
Question #1: Is this a valid option, to patch the kernel like that? (If 
YES -> Next Question)
Question #2: Is it bad to have two lan0 entries after a fresh boot in 
/proc/interrupts, although there is just only one NIC in my system?
Question #3: After suspend (S3) and wake up the system via PowerButton, 
I have three lan0 in /proc/interrupts. Is this even worse?
Question #4: Could this be an indicator for having problems with 
resuming from S3 via WOL (magic packet)?

With one older kernel (2.6.17-rc1) I've found a constellation where I at 
least could WOL the system from S3 up to three times, the forth time it 
died. The same kernel-config doesn't work here at all.

Regards,

Andreas.

###### BEFORE S3###(have a look at lan0#)############
           CPU0
  0:    131157    IO-APIC-edge  timer
  1:    93    IO-APIC-edge  i8042
  8:    4    IO-APIC-edge  rtc
  9:    0   IO-APIC-level  acpi
 12:    3868    IO-APIC-edge  i8042
 14:    14283    IO-APIC-edge  ide0
 16:    49265   IO-APIC-level  ohci_hcd:usb1, lan0, lan0
 17:    3680   IO-APIC-level  ohci_hcd:usb2, NVidia nForce2
 18:    0   IO-APIC-level  ehci_hcd:usb3
 19:    284529   IO-APIC-level  saa7146 (0)
 20:    36053   IO-APIC-level  nvidia
NMI:    0
LOC:    130928
ERR:    0
MIS:    0


####### AFTER RESUME FROM S3 VIA POWERBUTTON ########
           CPU0
  0:    359990    IO-APIC-edge  timer
  1:    3029    IO-APIC-edge  i8042
  8:    4    IO-APIC-edge  rtc
  9:    0   IO-APIC-level  acpi
 12:    19715    IO-APIC-edge  i8042
 14:    18292    IO-APIC-edge  ide0
 16:    140356   IO-APIC-level  lan0, lan0, lan0, ohci_hcd:usb2
 17:    3680   IO-APIC-level  ohci_hcd:usb3, NVidia nForce2
 18:    1   IO-APIC-level  ehci_hcd:usb1
 20:    105779   IO-APIC-level  nvidia
NMI:    0
LOC:    359315
ERR:    0
MIS:    0

###### lspci ##########
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:08.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
0000:02:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce 
FX 5200] (rev a1)

####### ver_linux on a DEBIAN SID#########
Gnu C                  4.0.4
Gnu make               3.81rc1
util-linux             2.12r
mount                  2.12r
modutils               3.2.2
e2fsprogs              1.39-WIP
jfsutils               1.1.8
xfsprogs               2.7.14
quota-tools            3.13.
PPP                    2.4.4b1
isdn4k-utils           3.8
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.94
Modules Loaded         b2c2_flexcop_pci b2c2_flexcop mt352 mt312 bcm3510 
nxt200x dvb_pll lgdt330x dvb_ttpci l64781 saa7146_vv video_buf saa7146 
v4l1_compat v4l2_common videodev ves1820 tda8083 sp8870 ves1x93 
ttpci_eeprom snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc sd_mod 
ohci_hcd ehci_hcd usb_storage scsi_mod libusual usbhid usbcore stv0299 
dvb_core stv0297 firmware_class nvidia cpufreq_nforce2 forcedeth rtc

more precise specs about my system: http://as68.homeip.net/2.6.17-rc4-mm2/
