From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 09:56:40 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04D4B14E@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42090 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750921AbWC2R4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 12:56:52 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: glen martin <lists@locutory.org>, linux-acpi@vger.kernel.org

Does this machine boot Windows ok?


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of glen martin
> Sent: Wednesday, March 29, 2006 9:51 AM
> To: linux-acpi@vger.kernel.org
> Subject: no /proc/acpi, trying to dump dsdt to a file
> 
> Greetings,
> 
> I've done some searches, poked around in the kernel source and doc,
> can't seem to find anything relevant.
> 
> kernel is 2.6.15, with gentoo patches and the patch to load a dsdt
from
> initrd.
> 
> I'm trying to dump my dsdt, but there is no /proc/acpi, let alone
> /proc/acpi/dsdt.
> 
> Is there something special needed to make /proc/acpi show up? Or other
> way to get at the existing dsdt in this situation?
> 
> The dsdt table in my BIOS is broken, in case that's relevant and
> nonobvious. :)  I'm hoping the broken existing table isn't what is
> blocking the /proc/acpi ...
> 
> The other interesting (to me, anyway) snippet is that
CONFIG_ACPI_SYSTEM
> doesn't show up when 'make menuconfig', but is set to 'Y' in the
.config
> file.  /drivers/acpi/system.o is built.
> 
> I've tried booting with various kernel parameters, disabling variously
> acpi, apic and lapic. no difference in behavior. right now they're all
> turned on (no special parms on kernel line).
> 
> Here's a snippet from my .config
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_CUSTOM_DSDT_INITRD=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_X86_PM_TIMER=y
> # CONFIG_ACPI_CONTAINER is not set
> 
> Here's the dmesg output when loading the existing BIOS DSDT, in case
> that is relevant.
> 
> ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not
found.
>  tbxface-0109 [02] load_tables           : ACPI Tables successfully
> acquired
> nssearch-0311: *** Error: ns_search_and_enter: Bad character in ACPI
> Name: 43035350
>  dswload-0292: *** Error: Looking up [0x43035350] (NON-ASCII)
>  in namespace, AE_BAD_CHARACTER
>   psloop-0287 [09] ps_parse_loop         : During name lookup/catalog,
> AE_BAD_CHARACTER
>  tbxface-0115: *** Error: acpi_load_tables: Could not load namespace:
> AE_BAD_CHARACTER
>  tbxface-0123: *** Error: acpi_load_tables: Could not load tables:
> AE_BAD_CHARACTER
> ACPI: Unable to load the System Description Tables
> 
> 
> Any suggestions?
> 
> Thanks in advance,
> 
> glen
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
