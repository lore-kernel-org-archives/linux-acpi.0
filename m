From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [2.6.28-rc2] EeePC ACPI errors & exceptions
Date: Tue, 28 Oct 2008 09:32:26 +0800
Message-ID: <1225157546.5189.73.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0810261221350.3386@nehalem.linux-foundation.org>
	 <4FFA7B13E0%linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17199 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbYJ1BZw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Oct 2008 21:25:52 -0400
In-Reply-To: <4FFA7B13E0%linux@youmustbejoking.demon.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Salt <linux@youmustbejoking.demon.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2008-10-27 at 15:52 -0700, Darren Salt wrote:
Will you please attach the output of acpidump?
Of course you can file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the output of acpidump, dmesg.

It will be better if you can add the boot option of "printk.time=1".
thanks.

> EeePC 901, BIOS revision 1603, current Debian lenny; running on AC.
> 
> I've noticed the following errors & exceptions, apparently coinciding with
> the startup of xfce4-sensors-plugin:
> 
> ACPI: EC: missing confirmations, switch off interrupt mode.
> ACPI Exception (evregion-0419): AE_TIME, Returned by Handler for [EmbeddedControl] [20080926]
> ACPI Error (psparse-0524): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.BST2] (Node f7030d38), AE_TIME
> ACPI Error (psparse-0524): Method parse/execution failed [\_SB_.PCI0.CBST] (Node f70336f8), AE_TIME
> ACPI Error (psparse-0524): Method parse/execution failed [\_SB_.PCI0.BAT0._BST] (Node f7031c48), AE_TIME
> ACPI Exception (battery-0360): AE_TIME, Evaluating _BST [20080926]
> 
> Also, this (which, unlike the above, is also present with 2.6.27.*):
> 
> ACPI: I/O resource 0000:00:1f.3 [0x400-0x41f] conflicts with ACPI region SMRG [0x400-0x40f]
> ACPI: Device needs an ACPI driver
> 
> Full dmesg & config are attached.
> 
> (The Elantech touchpad patch from http://arjan.opmeer.net/elantech/ is
> applied to this kernel.)
> 

