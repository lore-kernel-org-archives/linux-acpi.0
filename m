From: Martin Zuther <mzuther@mzuther.de>
Subject: Yet another DSDT problem
Date: Sun, 10 Sep 2006 22:19:26 +0200
Message-ID: <4504734E.6000501@mzuther.de>
References: <200609041332.19780.rjw@sisk.pl> <200609071234.21782.rjw@sisk.pl> <20060907220837.GI29890@elf.ucw.cz> <200609080022.26726.rjw@sisk.pl>
Reply-To: mz_mail@mzuther.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail2.dbdserver.de ([212.88.144.29]:7332 "EHLO
	mail2.dbdserver.de") by vger.kernel.org with ESMTP id S964862AbWIJUQK
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Sep 2006 16:16:10 -0400
Received: from [145.254.183.38] (dialin-145-254-183-038.pools.arcor-ip.net [145.254.183.38])
	by mail2.dbdserver.de (Postfix) with ESMTP id 32341278010
	for <linux-acpi@vger.kernel.org>; Sun, 10 Sep 2006 22:16:05 +0200 (CEST)
In-Reply-To: <200609080022.26726.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear list members,

my system doesn't shut down properly.

  Kubuntu Dapper 6.06 LTS (packages updated regularly)
  Current kernel image of 2.6.15-26-686

  Mainboard: MSI 865PE Neo2-P
  Processor: Intel Pentium 4 2.8E GHz 800 MHz (Box)
  RAM: 3 x 512 MB DDR
  Video card: NVidia GeForce 5200 FX

  Keyboard: Logitech iTouch Internet
  Graphics tablet: Wacom Intuos A5

I remember having the same problem under
Debian 3.0, but as that encounter was somewhat short and is about a year
ago, the only thing I can remember is that it was a 2.6 kernel as well.

Kubuntu also hints that I have a partial ACPI installation in "System
Settings - Laptop and Power
- - Laptop Battery - Power Control".

This is probably related to "acpi -V" producing the error message "No
support for device type: thermal" and having almost no useful entries in
"/proc/acpi/...".

When I remove the boot option "quiet splash" I get the following
messages during shutdown:

  * Will now halt.
  md: stopping all md devices
  usb 4-2: new full speed USB device using uhci_hcd and address 3
  usb 4-2: not running at top speed; connect to a high speed hub
  Shutdown: hda
  ACPI-0517: *** Error: Method parse/execution failed
  [SB_.PCI0.IDE0.GTM_] (Node dffe5d60), AE_AML_PACKAGE_LIMIT
  ACPI-0517: *** Error: Method parse/execution failed
  [_SB_.PCI0.IDE0.CHN0._GTM (Node dffe5fa0), AE_AML_PACKAGE_LIMIT
  Power down.
  acpi_power_off called

Then there's a click as my hard drives shut down, and that's about as
near as I ever get to shutting down my computer. The only thing working
at this stage are pressing the power button (for unusual 4 seconds) or
the reset button.

Also, when I reboot the computer from KDE, it does as told, but when in
the BIOS routines, there's a noticeable pause and a click when my two
S-ATA drives are checked. I don't have a problem like that when
rebooting Win XP (I have a dual boot system).

I had a look at several forums and had a go at fixing my DSDT.dsl (you
can find the original file at
http://www.ubuntuusers.de/paste/2441/?format=txt). As running the
recommended method for including a new DSDT failed to produce a bootable
image, a found a workaround (and I'm a little proud, being still new to
Linux... <g>):

  sudo cp ~/DSDT.aml /etc/mkinitramfs/DSDT.aml
  sudo mkinitramfs -o /boot/initrd.img-`uname -r`-acpifix

After rebooting with such an image I find this in the syslog:

  ACPI-0284: *** Info: Table [DSDT] replaced by host OS
  ACPI: Looking for DSDT in initramfs... found /DSDT.aml ...
  successfully read 13614 bytes from /DSDT.aml
  ACPI: Using customized DSDT

As this message vanishes when I run an original image, I think it has
worked.

Es scheint also geklapt zu haben. Zeit, sich dem Problem zuzuwenden -
ein Lauf von iasl -sa DSDT.sdl ergibt die folgende Meldung:

So here are the warnings I found when recompiling the DSDT:

  DSDT.dsl  4034:                 Method (STM, 0, Serialized)
  Warning  1086 -                           ^ Not all control
    paths return a value (STM_)

  DSDT.dsl  4359:     Method (_WAK, 1, NotSerialized)
  Warning  1079 -                ^ Reserved method must return a
    value (_WAK)

  ASL Input:  DSDT.dsl - 4458 lines, 150438 bytes, 1514 keywords
  AML Output: DSDT.aml - 13606 bytes 500 named objects 1014
    executable opcodes

  Compilation complete. 0 Errors, 2 Warnings, 0 Remarks,
    462 Optimizations

For the second warning I use the googled "standard solution"

  Return(Package(0x02){0x00, 0x00})

So the problem seems to lie within the first warning. As my machine code
knowledge is based on the Z80 and was lost somewhere years ago, I'd like
to ask for your help. I also checked the WWW and the ACPI spec for
ideas, but couldn't come up with anything useful.

Any help is deeply appreciated!

Martin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBHNOx8z6qIGmGv0RAsFfAJ90hHJN7Wbvntht5JUtY03smP+4TQCeObZB
zoCa37FxWn2A/+VmdwrdeiE=
=n1LD
-----END PGP SIGNATURE-----

