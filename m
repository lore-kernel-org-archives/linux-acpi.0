From: Aleksandar Markovic <acojlo@gmail.com>
Subject: Suspend - FS Amilo Pro 2030
Date: Tue, 25 Jul 2006 12:16:52 +0200
Message-ID: <200607251216.52159.acojlo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:14862 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751561AbWGYKRL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 06:17:11 -0400
Received: by nz-out-0102.google.com with SMTP id l1so530566nzf
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jul 2006 03:17:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi to everyone out in the working world of open source society :)

I want to enable s3 suspend resume and suspend to disk functionality on my 
laptop. I think this will benefit the linux community.

Let me first argue about hardware. It is a laptop, sold under Fujitsu Siemens 
brand by Amilo Pro 2030 name. It is very cheap laptop (around 600 euros in 
Serbia) in this part of the world - Europe, and therefore it will enable many 
people of benefiting by using laptops. The model is sold all around the 
world, so if we succeed in S3, S4 operations many will benefith. Actualy, 
Laptop is sold with Linux on the live CD and with no operating system 
preinstalled on the hard disk. Little more hardware facts: 

VIA Technologies, Inc. CN700/VN800/P4M800CE/Pro Host Bridge
VIA Technologies, Inc. PT890 Host Bridge
VIA Technologies, Inc. VT8237 PCI Bridge
Broadcom Corporation BCM4318 WLAN
Texas Instruments PCIxx21/x515 Cardbus Controller
Texas Instruments OHCI Compliant IEEE 1394 Host Controller
VIA VT6420 SATA RAID Controller
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
VT82xxxxx UHCI USB 1.1 Controller
VIA Technologies, Inc. USB 2.0
Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
VT8233/A/8235/8237 AC97 Audio Controller
Inc. AC'97 Modem Controller
Inc. VT6102 [Rhine-II]
VIA Technologies, Inc. UniChrome Pro IGP

Maybe you consider this facts unimportant, but I'm not so much educated in 
technical sciences. Actually, I'm a law student :)

At this point there was some problems with fan control, but I've solved that 
by replacing DSDT. 

I have a (K)ubuntu distribution with kernel upgraded at 2.6.18-rc2 and 
configured for this hardware (hd support (via_sata) is precompiled in 
kernel - not in module).

So, here is the description of suspend / resume problems:

1. S3: System goes into S3 - everything becomes quiet - just  power led is 
blinking - normal. Pressing the power button - to resume - fans start 
spinning, cd make some noise, there is some activity by hard disk but - 
keyboard does not react - caps lock pressing does not change led light, 
pressing wlan hotkey does not change it's led light,hd led is off, screen is 
off. Power led continues to blink. Only solution is to power off the system 
by pressing the power button.

2. Suspend to disk: Screen becomes off and system freezes - keyboard is still 
active. It lasts for few minutes after what I allways turned it off.


So, is anyone willing to support me on this? I have no problem in trying to 
diagnose the problem, but I need someone experienced to guide me.

Sincerely,
Aleksandar Markovic


--
What if God decides, in very next moment, to sacrifice all of us and leave 
just you and your wife or girl? Are you capable of thinking about future and 
realising the past is not anymore important. Are you at the level of being 
able to cope with everyday problems? Will you be at the level of producing 
the whole new brave world? Have you grown inaf to be not anymore green? Do 
you live the love, hope, faith and good?
