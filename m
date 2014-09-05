From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Subject: Re: ACPI: Invalid active2 threshold
Date: Fri, 5 Sep 2014 08:24:18 +0200
Message-ID: <201409050824.18447.a.miskiewicz@gmail.com>
References: <201409041840.04182.a.miskiewicz@gmail.com> <201409050703.56802.a.miskiewicz@gmail.com> <1409896948.8085.156.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35566 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaIEGYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2014 02:24:23 -0400
Received: by mail-la0-f50.google.com with SMTP id mc6so13202840lab.37
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 23:24:21 -0700 (PDT)
In-Reply-To: <1409896948.8085.156.camel@rzhang1-toshiba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Friday 05 of September 2014, Zhang Rui wrote:
> On Fri, 2014-09-05 at 07:03 +0200, Arkadiusz Miskiewicz wrote:
> > On Friday 05 of September 2014, Zhang Rui wrote:
> > > On Thu, 2014-09-04 at 21:21 +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, September 04, 2014 06:40:04 PM Arkadiusz Miskiewic=
z=20
wrote:
> > > > > Hi.
> > > > >=20
> > > > > I'm using 3.17.0-rc3-00002-g7505cea kernel on Dell XPS 15 mac=
hine:
> > > > > DMI: Dell Inc. XPS 15 9530/XPS 15 9530, BIOS A06 07/16/2014
> > > > > (this is latest bios)
> > > > >=20
> > > > > After loading thermal acpi driver I get:
> > > > >=20
> > > > > [54136.633643] ACPI: Invalid active2 threshold
> > > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> this is a BIOS bug. _AC2 is defined while _AL2 is not, thus this is a=
n
> invalid active trip point.
> But it won't hurt IMO, because there are two ACPI Fan devices, and th=
ey
> are both used (for active trip point 0 and 1) in the ACPI thermal
> management in your laptop.
>=20
> > > > > [54136.633761] thermal LNXTHERM:00: registered as thermal_zon=
e6
> > > > > [54136.633763] ACPI: Thermal Zone [TZ00] (28 C)
> > > > > [54136.634009] thermal LNXTHERM:01: registered as thermal_zon=
e7
> > > > > [54136.634011] ACPI: Thermal Zone [TZ01] (-266 C)
>=20
> This is more serious to me.
> can you please file a bug at
> https://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> and attach your acpidump output there.

Done
https://bugzilla.kernel.org/show_bug.cgi?id=3D83921

>=20
> thanks,
> rui
>=20
> > > > > I assume bios is buggy (right?)
> > > >=20
> > > > Well, we don't seem to like the value for some reason.  Also th=
e -266
> > > > C for TZ01 looks suspicious.
> > > >=20
> > > > > What problems can happen to this machine due to this problem?=
 It is
> > > > > quite hot frequently, so I wonder if there is some thermal
> > > > > management problem with it.
> > > >=20
> > > > I'm leaving this question to Rui.
> > >=20
> > > It looks like ACPI thermal driver fails to parse _AC2 control met=
hods.
> > > please attach the acpidump output.


--=20
Arkadiusz Mi=C5=9Bkiewicz, arekm / maven.pl

Q: vger.kernel.org postmasters - always rude and impolite, hmm?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
