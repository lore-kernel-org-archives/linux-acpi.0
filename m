From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: BIOS-controlled FN keys works only with "acpi={off | ht}" on
	Samsung P500
Date: Tue, 15 Jul 2008 08:49:57 +0800
Message-ID: <1216082997.1617.87.camel@rzhang-dt>
References: <20080714213755.7e892550@paolo-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62407 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759747AbYGOAvB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 20:51:01 -0400
In-Reply-To: <20080714213755.7e892550@paolo-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, 2008-07-14 at 21:37 +0200, Paolo Ornati wrote:
> Hello,
> 
> on this laptop, Samsung NP-P500Y, some function keys are
> BIOS-controlled (they work before Linux boots).
> 
> As soon as Linux boots they stop working. Trying some boot options I've
> found that "acpi=off" makes them work and the less drastic "acpi=ht"
> works too.
> 
> I'm mostly interested in brightness adjusting... and since both
> xbacklight and radeontool fail I've to use "acpi=ht".

Please file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the dmesg, acpidump output.

Please run "grep . /sys/firmware/acpi/interrupts/*" both before and
after pressing the brightness hotkey and attach the test result as well.

thanks,
rui

> 
> Disabling ACPI is not a good idea on a laptop... so other boot
> options/patches to try are welcomed :)
> 
> 
> tested kernels: 2.6.22 / 2.6.24 (Ubuntu)
> 	2.6.18 - 2.6.26-rc9 (vanilla)
> 
> 
> lspci:
> 00:00.0 Host bridge: ATI Technologies Inc Unknown device 7930
> 00:01.0 PCI bridge: ATI Technologies Inc Unknown device 7932
> 00:05.0 PCI bridge: ATI Technologies Inc Unknown device 7935
> 00:06.0 PCI bridge: ATI Technologies Inc Unknown device 7936
> 00:07.0 PCI bridge: ATI Technologies Inc Unknown device 7937
> 00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA
> 00:13.0 USB Controller: ATI Technologies Inc SB600 USB (OHCI0)
> 00:13.1 USB Controller: ATI Technologies Inc SB600 USB (OHCI1)
> 00:13.2 USB Controller: ATI Technologies Inc SB600 USB (OHCI2)
> 00:13.3 USB Controller: ATI Technologies Inc SB600 USB (OHCI3)
> 00:13.4 USB Controller: ATI Technologies Inc SB600 USB (OHCI4)
> 00:13.5 USB Controller: ATI Technologies Inc SB600 USB Controller (EHCI)
> 00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 14)
> 00:14.1 IDE interface: ATI Technologies Inc SB600 IDE
> 00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia
> 00:14.3 ISA bridge: ATI Technologies Inc SB600 PCI to LPC Bridge
> 00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
> 01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Xpress 1250
> 02:00.0 Ethernet controller: Atheros Communications Inc. AR242x 802.11abg Wireless PCI Express Adapter (rev 01)
> 05:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8039 PCI-E Fast Ethernet Controller (rev 15)
> 
> 
> dmidecode and dmesg attached

