From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: hwapci-0142 error
Date: Mon, 21 Jul 2008 09:17:41 +0800
Message-ID: <1216603061.4135.17.camel@yakui_zhao.sh.intel.com>
References: <20080720001417.GA22429@eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3009 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657AbYGUBFo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jul 2008 21:05:44 -0400
In-Reply-To: <20080720001417.GA22429@eorbit.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Collins <chris@eorbit.net>
Cc: linux-acpi@vger.kernel.org

On Sat, 2008-07-19 at 17:14 -0700, Chris Collins wrote:
> Hello,
> 
> ACPI doesn't work on my desktop, a VIA Apollo MVP3 chipset.
> 
> I have a 12/20/2000 dated award BIOS.
> 
> I've installed a current slackware distro, 12.1.
> 
> In my BIOS setup I enabled ACPI, and disabled APM
> 
> In my kernel parameters, in Lilo I have tried each 
> of these in succession to see what happens:
> 
> 
> ******************************************
> image = /boot/vmlinuz-huge-2.6.24.5
>   root = /dev/hda1
>   label = Linux1
> # append="acpi=ht"
> # append="pci=noacpi"
> # append="acpi=noirq"
> # append="pnpacpi=off"
> # append="noapic"
> # append="nolapic"
>   read-only
> ******************************************
> 
> Here is what happens from bootup
> 
> chrie@darkstar:~# grep -i ACPI /var/log/dmesg
>  BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
>  BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
> ACPI: RSDP 000F6FF0, 0014 (r0 AWARD )
> ACPI: RSDT 17FF3000, 0028 (r1 AWARD  AWRDACPI 42302E31 AWRD        0)
> ACPI: FACP 17FF3040, 0074 (r1 AWARD  AWRDACPI 42302E31 AWRD        0)
> ACPI: DSDT 17FF30C0, 1EA8 (r1 AWARD  AWRDACPI     1000 MSFT  100000B)
> ACPI: FACS 17FF0000, 0040
> ACPI: DMI BIOS year==0, assuming ACPI-capable machine
> ACPI: PM-Timer IO Port: 0x4008
> ACPI: Core revision 20070126
> ACPI: setting ELCR to 0200 (from 0e20)
> ACPI Error (hwacpi-0142): Hardware did not change modes [20070126]
It seems that OS can't switch the system from Legacy mode to ACPI mode.
OS will try to check whether the system is in ACPI mode. Unfortunately
the hardware can't give the correct response. Maybe it is related with
the BIOS. 
Will you please check whether there is available BIOS to upgrade?

Anyway, please attach the output of acpidump.
Thanks.

> ACPI Error (evxfevnt-0086): Could not transition to ACPI mode [20070126]
> ACPI Warning (utxface-0139): AcpiEnable failed [20070126]
> ACPI: Unable to enable ACPI
> ACPI: Interpreter disabled.
> pnp: PnP ACPI: disabled
> 
> 
> --Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

