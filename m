From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending in the middle
  of EC transaction
Date: Mon, 01 Feb 2010 13:22:55 +0300
Message-ID: <4B66AB7F.7050908@suse.de>
References: <201001310029.48717.rjw@sisk.pl> <9b2b86521001310611m339862afw73410dc7eb5692c8@mail.gmail.com> <1264957760.7264.3.camel@maxim-laptop> <20100201094643.GB8740@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:48416 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011Ab0BAKWv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 05:22:51 -0500
In-Reply-To: <20100201094643.GB8740@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>

Henrique de Moraes Holschuh =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sun, 31 Jan 2010, Maxim Levitsky wrote:
>> Unfortunately, this patch even causes regressions on my notebook (it
>> survive 63 hibernate cycles), but now I battery driver reports 'batt=
ery
>> absent', backlight driver reports 0 brightness, but reload helped.
>=20
> ...
>=20
>> I think that not only _PTS ans _WAK are problematic. What about othe=
r
>> ACPI drivers that start accessing the EC before it is resumed?
>> I think that these cause the problems I observe.
>=20
> ACPI drivers might access the EC (even indirectly, through the DSDT).=
  And
> platform drivers do often access the EC both at suspend and resume ti=
me.
Actually, only SBS and thinkpad-acpi access EC directly. All others go =
through
DSDT for access. Still, stopping EC in .suspend is too early, IMHO...
>=20
> This needs some sort of strong ordering, the EC must suspend last, an=
d
> resume first (as seen by any ACPI and ACPI-aware drivers such as liba=
ta,
> some platform drivers, etc).  If EC interrupts are a problem, maybe i=
t can
> be kicked to poll mode for the suspend/resume transition?
It's this way already for about a year now... The problem is that EC dr=
iver might be=20
stopped in middle of the transaction, thus leaving EC in unknown state =
for BIOS or=20
switch-over kernel.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
