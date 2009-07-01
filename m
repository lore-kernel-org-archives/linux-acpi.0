From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer
Date: Wed, 01 Jul 2009 22:27:15 +0400
Message-ID: <4A4BAA83.8090600@suse.de>
References: <4A4BA8F9.9070803@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50592 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753360AbZGASrY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2009 14:47:24 -0400
In-Reply-To: <4A4BA8F9.9070803@marcansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hector Martin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> My Acer Aspire 8930G laptop reports the battery current as a 16-bit
> signed negative when it is charging. It also reports it as 0x10000 wh=
en
> the current is 0. This patch adds a quirk for this which takes the
> absolute value of the reported current cast to an s16. This is a DSDT
> bug present in the latest BIOS revision (the EC register is 16 bits
> signed and the DSDT attempts to take the 16-bit two's complement of
> this, which works for discharge but not charge. It also breaks zero
> values because a 32-bit register is used and the high bits aren't thr=
own
> away).
>=20
> I've enabled this for all Acer systems which report in mA units. This
> should be safe since it won't break compliant systems unless they rep=
ort
> a current above 32A, which is insane.
>=20
>=20
Could you please use bitfields? Please take a look at drivers/acpi/ec.c=
 as an example.

Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
