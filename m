From: Norbert Preining <preining@logic.at>
Subject: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sat, 25 Oct 2008 23:46:02 +0200
Message-ID: <20081025214602.GB27030@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:33231 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYJYVqH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 17:46:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it, drzeus-mmc@drzeus.cx, linux-acpi@vger.kernel.org

Dear all,

I am trying to get the beast from $subject more or less working. Here is
the current status running 2.6.27.3:
config: http://www.logic.at/people/preining/sony/vgn-z11vn/config-2.6.27
dmesg output: http://www.logic.at/people/preining/sony/vgn-z11vn/dmesg.txt
DMI decode: http://www.logic.at/people/preining/sony/vgn-z11vn/dmidecode.txt
DSDT: http://www.logic.at/people/preining/sony/vgn-z11vn/DSDT.dsl

Working fine:
  eth Intel e1000e
  wlan: iwlagn (with hangs now and then)
  intel graphics
  nvidia graphics (both built in, switch on the fly on vista possible,
    on linux needs reboot)
  sata harddisk and cd
  usb camera usb_video_class 05ca:18b0 Ricoh Co., Ltd
  audio: HDA
  touchpad: AlpsPS/2
  usual stuff like cpufreq etc

not tested (but detected)
  bluetooth (044e:3017 Alps Electric Co., Ltd)
  cardbus
  firewire (Ricoh Co Ltd R5C832, config_firewire_ohci)


=====================================================

not working, and here we start with the problems:

WLAN
====
iwl sometimes shuts itself down and immediately again turn on, the rest
of the computer hangs for that time, about 2sec:
[  120.345217] PM: Removing info for No Bus:iwl-phy0:assoc
[  120.346008] PM: Removing info for No Bus:iwl-phy0:RX
[  120.347747] PM: Removing info for No Bus:iwl-phy0:TX
[  120.347803] PM: Removing info for No Bus:iwl-phy0:radio
[  122.344972] iwlagn 0000:06:00.0: PCI INT A disabled
[  122.482967] iwlagn 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  122.483150] iwlagn 0000:06:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[  122.510812] PM: Adding info for No Bus:iwl-phy0:radio
[  122.511741] Registered led device: iwl-phy0:radio
[  122.511856] PM: Adding info for No Bus:iwl-phy0:assoc
[  122.512627] Registered led device: iwl-phy0:assoc
[  122.512716] PM: Adding info for No Bus:iwl-phy0:RX
[  122.513395] Registered led device: iwl-phy0:RX
[  122.513481] PM: Adding info for No Bus:iwl-phy0:TX
[  122.514227] Registered led device: iwl-phy0:TX

WWAN
====
  after rebooting *from* Vista to Linux I see the following USB device:
  Bus 004 Device 002: ID 0af0:6911 Option
  which is an Option Globetrotter HSDPA Modem
  but cold-booting directly into linux this device does not appear
  functionality not tested since devices are strangly enough not created!
  Something similar has been reported in 
    http://fedoraforum.org/forum/showthread.php?t=196654



Card reader
===========

SD/MMC card reader
  PCI: 0b:04.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)
MemoryStick card reader
  PCI: 0b:04.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus
Host Adapter (rev 11)
  
  When I introduce the a SD card nothing works, but the kernel log shows
  me:
  mmc0: Reset 0x1 never completed.
  sdhci: ============== REGISTER DUMP ==============
  sdhci: Sys addr: 0x00000000 | Version:  0x00000400
  sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
  sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
  sdhci: Present:  0x00020000 | Host ctl: 0x00000000
  sdhci: Power:    0x0000000e | Blk gap:  0x00000000
  sdhci: Wake-up:  0x00000000 | Clock:    0x00008003
  sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
  sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
  sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
  sdhci: Caps:     0x01c021a1 | Max curr: 0x00000040
  sdhci: ===========================================




not supported devices
=====================

Fingerprint Scanner TouchStrip USB: Bus 003 Device 002: ID 147e:1000
  no device driver as far as I see




(sony_)acpi things:
===================

fans practically permanently running, that has been reported on several
forums. Is there a way around it?


brightness adjustment via hardware buttons does not work
there is /sys/class/backlight/sony but writing to brightness therein
does not do anything, neither does xbrightness, nor are any events sent
(see below for unknown methods in SNC/SPIC)


rfkill switch does turn of bluetooth AND WLAN, which is not what I want.
Problably only the SNC/SPIC routines can do something like turning
on/off specific hardware, see below.



SNC/SPIC sony_acpi stuff
========================
(as documented in Documentation/laptops/sony-acpi.txt)

The list of reported methods together with comments of my self and my
findings:

methods as reported by sony-laptop debug=1
method: name: _INI, args 0
	called
method: name: ECON, args 1
	unknown
method: name: GBRT, args 0
	get brightness, not working
method: name: SBRT, args 1
	set brightness, not working

method: name: PWAK, args 0
	unknown
method: name: EAWK, args 1
	unknown

	testing those two as reading and writing pair:
	reading PWAK gives 0
	writing "1" to it does not change anything AFAIS

method: name: SN00, args 1
	unknown
method: name: SN01, args 0
	unknown
method: name: SN02, args 1
	used in sony_nc_C_enable
method: name: SN03, args 1
	used in sony_nc_C_enable
method: name: SN04, args 0
	unknown
method: name: SN05, args 1
	unknown
method: name: SN06, args 1
	unknown
method: name: SN07, args 1
	used in sony_nc_C_enable


method: name: SNIN, args 0
	unknown
method: name: SNCF, args 2
	unknown
method: name: SNNE, args 1
	unknown
	testing these three in the a way that
		SN_set -> SNIN
		SN_get -> SNNE, SNCF	(no idea if this is the way for 2 args)
	reading SN: 16
	writing "1" or "1 2" does not change anything in the reading of SN
	nor do I see changes


method: name: F100, args 0
method: name: F113, args 0
method: name: F101, args 0
method: name: F105, args 0
method: name: F114, args 0
method: name: F115, args 0
method: name: F11D, args 0
method: name: F119, args 0
method: name: F121, args 0
method: name: F122, args 0
method: name: F124, args 0
method: name: F125, args 0
method: name: F126, args 0
method: name: F128, args 0
	all unknown
method: name: GPID, args 0
	PID_get
	returns 13


method: name: HSC0, args 0
method: name: HSC1, args 0
method: name: HSC2, args 0
method: name: HSC3, args 1
method: name: HSC4, args 1
	all unknown
	testing: 
	  HSC0 only get
	  HSC13 set/get	
	  HSC24 set/get
	reading HSC24 (ie HSC2) gives keyboard.c: can't emulate rawmode for keycode 240
	same with writing to HSC13 (HSC3)
	booting in normal mode gives values:
		HSC0:	0
		HSC13:	2
		HSC24:	1
	writing "0" to HSC24 did not change anything
	writing "1" to HSC13 did not change anything


	booting with nvidia card selected with hot switch
		HSC0:	0
		HSC13:	0
		HSC24:	1 but also echos some strange symbol to stdout
			  which *cannot* be redirected with > or 2>


method: name: HOMP, args 0
	reading gives 0, cannot be changed, same with nvidia selected
	unknown



other things with sony_acpi:
  writing and reading to wwanpower is possible EVEN if the wwan
  device is not present/exhibited/listed as device (lsusb)



=======================

So, that are my current findings. If anyone has some suggestions or
ideas please let me know, I will happily hack my kernel or anything
else.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
BROMSGROVE
Any urban environment containing a small amount of dogturd and about
forty-five tons of bent steel pylon or a lump of concrete with holes
claiming to be sculpture. 'Oh, come my dear, and come with me. And
wander 'neath the bromsgrove tree' - Betjeman.
			--- Douglas Adams, The Meaning of Liff
