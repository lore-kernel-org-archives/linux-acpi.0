From: Fabio <fabio.venturi@studenti.unipr.it>
Subject: Gentoo on Acer Aspire 3502WLCi with bugged DSDT (Phoenix BIOS)
Date: Wed, 18 Jan 2006 19:06:06 +0100
Message-ID: <1137607566.7720.23.camel@bluestar>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from as1.cineca.com ([130.186.84.251]:18914 "EHLO as1.cineca.com")
	by vger.kernel.org with ESMTP id S964869AbWARSGb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 13:06:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by as1.cineca.com (Postfix) with ESMTP id A92D771497
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 19:06:30 +0100 (CET)
Received: from unipr.mm.cineca.it (unipr.mm.cineca.it [130.186.10.204])
	by as1.cineca.com (Postfix) with ESMTP id 28CC2714AF
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 19:06:25 +0100 (CET)
Received: from bluestar (host24-202.pool8255.interbusiness.it [82.55.202.24])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	as user fabio.venturi@studenti.unipr.it by unipr.mm.cineca.it (Postfix) with ESMTP id 19D2E44AB34
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 19:06:24 +0100 (MET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Greetings to anyone in the ML,
I got the laptop in object with a bugged DSDT (REALLY?!?!?!  :o)
So I downloaded a fixed DSDT from the acpi site and compiled it with
the iasl compiler.
Then I patched the kernel (2.6.15) so now it can read a custom DSDT
and I put the new DSDT.aml in /boot

I read on a gentoo forum that i can pass the file to the kernel 
like a initrd image, so i modified my grub like this:

[...]
title Gentoo GNU/Linux (Fixed DSDT)
kernel (hd0,2)/boot/bzImage-2.6.15 root=/dev/hda3
initrd=(hd0,2)/boot/DSDT.aml
[...]

but on restart i find:
fabio@bluestar ~ $ dmesg |grep -i dsdt
ACPI: DSDT (v001 PTLTD     661MX 0x06040000 MSFT 0x0100000e) @
0x00000000
ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
Table [DSDT](id 0006) - 485 Objects with 39 Devices 93 Methods 10
Regions

I tried to create an initrd.img with "mkinitrd initrd.img 2.6.15" and
then add the DSDT.aml to it by the initrd-add script,
but during the start-up the pc hangs with the message:
"error: Unable to mount root fs on unknown-block(3,3)"

I don't know what to do, hope someone
could help me, thank you in advance
Fabio

