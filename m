From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] ACPI autoloading - ACPICA adjustance
Date: Tue, 3 Jul 2007 03:58:58 -0400
Message-ID: <200707030358.59031.lenb@kernel.org>
References: <1182111854.4204.4.camel@noname>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50121 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbXGCH7J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Jul 2007 03:59:09 -0400
In-Reply-To: <1182111854.4204.4.camel@noname>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Sunday 17 June 2007 16:24, Thomas Renninger wrote:
> Define standardized HIDs ...

> Index: linux-2.6.22-rc4/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-2.6.22-rc4.orig/include/acpi/acpi_drivers.h
> +++ linux-2.6.22-rc4/include/acpi/acpi_drivers.h
> @@ -34,16 +34,33 @@
>  #define ACPI_BUS_COMPONENT		0x00010000
>  #define ACPI_SYSTEM_COMPONENT		0x02000000
>  
> -/* _HID definitions */
> +/*
> +  _HID definitions
> +  HIDs starting with 'X' are self defined here and are used for devices where
> +  a HID does not exist in spec.
> +  HIDs must conform to (ACPI spec - 6.1.4):
>  
> -#define ACPI_POWER_HID			"power_resource"
> +  Numeric 32-bit compressed EISA type ID are not supported (never seen one as
> +  an ACPI HID?)
> +
> +  A valid PNP ID must be of the form AAA#### where A is an uppercase letter
> +  and # is a hex digit.
> +  A valid ACPI ID must be of the form ACPI#### where # is a hex digit.
> +
> +  and our self-defined: XAAA#### where A is an uppercase letter and # is a hex
> +  digit.

What was the criteria for inventing the XAAA#### format?
It doesn't comply with the PNP standard format above, since
it starts with four letters instead of three.

I don't think that "XVID0001" will be more meaningful than "video"
when seen in sysfs...

> +*/
> +
> +#define ACPI_POWER_HID			"XPWR0001"
>  #define ACPI_PROCESSOR_HID		"ACPI0007"
> -#define ACPI_SYSTEM_HID			"acpi_system"
> -#define ACPI_THERMAL_HID		"thermal"
> -#define ACPI_BUTTON_HID_POWERF		"button_power"
> -#define ACPI_BUTTON_HID_SLEEPF		"button_sleep"
> -#define ACPI_VIDEO_HID			"video"
> -#define ACPI_BAY_HID			"bay"
> +#define ACPI_SYSTEM_HID			"XSYS0001"
> +#define ACPI_THERMAL_HID		"XTHM0001"
> +#define ACPI_BUTTON_HID_POWERF		"XPBT0001"
> +#define ACPI_BUTTON_HID_SLEEPF		"XSBT0001"
> +#define ACPI_VIDEO_HID			"XVID0001"
> +#define ACPI_BAY_HID			"XBAY0001"
> +

If the criteria is to stay within an 8 character id length,
I'd rather spell a word with capital letters, and stick
in 0's where we don't need more letters:

POWER000
SYSTEM00
THERMAL0
PWRBTN00
SLEEPBTN
VIDEO000
DRIVEBAY

Or when we discussed this before, we though about not conflicting
with a standard (or vendor standard) name by becoming the Linux vendor --
say using  the "LNX" prefix, and trying to spell something useful
in the remaining 5 characters. eg.

LNXPOWER
LNXSYSTM
LNXTHERM
LNXSLPBN
LNXPWRBN
LNXVIDEO
LNXIOBAY

-Len
