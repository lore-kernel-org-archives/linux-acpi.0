From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: SRAT v1 support
Date: Fri, 15 May 2009 11:38:52 -0700
Message-ID: <86802c440905151138t42705477s95a972704db2ce9c@mail.gmail.com>
References: <4A0D8178.4060604@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:53231 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbZEOSiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2009 14:38:52 -0400
In-Reply-To: <4A0D8178.4060604@bull.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: xb <xavier.bru@bull.net>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len
Cc: linux-acpi@vger.kernel.org, Zoltan <zoltan.menyhart@bull.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 15, 2009 at 7:51 AM, xb <xavier.bru@bull.net> wrote:
> Recent linux kernels suppose that the =A0SRAT table is in rev 2 forma=
t (ACPI
> 3.0), but some BIOSes still provide SRAT table in rev 1.
> The rev 2 of the SRAT extension mainly provides an extension of the
> "proximity_domain" item from 8 bits to 32 bits, using a "reserved" fi=
eld of
> the structure.
> When the "reserved" field is not null, linux finds a wrong proximity =
domain,
> and numa initialization is wrong.
> Following patch tests the SRAT revision to allow a correct initializa=
tion:
>
> This patch tests the version of SRAT ACPI table to allow supporting S=
RAT rev
> 1 and SRAT rev 2.
>
> diff -Nru linux-2.6.29-rc7-orig/arch/x86/kernel/acpi/boot.c
> linux-2.6.29-rc7-tmp/arch/x86/kernel/acpi/boot.c
> --- linux-2.6.29-rc7-orig/arch/x86/kernel/acpi/boot.c =A0 =A02009-03-=
12
> 14:41:38.000000000 +0100
> +++ linux-2.6.29-rc7-tmp/arch/x86/kernel/acpi/boot.c =A0 =A02009-03-1=
6
> 14:52:07.000000000 +0100
> @@ -260,7 +260,8 @@
> }
>
> static int __init
> -acpi_parse_lapic(struct acpi_subtable_header * header, const unsigne=
d long
> end)
> +acpi_parse_lapic(const struct acpi_subtable_header * const header,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const unsigned long end, const int r=
ev)

do we need to pass that rev all over around?

looks like we could use one srat_version or pxm_mask variable to get
the same result.

YH
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
