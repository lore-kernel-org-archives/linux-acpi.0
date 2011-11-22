From: Greg KH <greg@kroah.com>
Subject: Re: [2.6.32] Please cherry-pick Toshiba Satellite DSDT corruption
 workaround
Date: Tue, 22 Nov 2011 14:36:01 -0800
Message-ID: <20111122223601.GB31434@kroah.com>
References: <20111118200908.3274.86645.reportbug@pingwin>
 <20111119051427.GB12471@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39813 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932114Ab1KVWj4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Nov 2011 17:39:56 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B1A4220E11
	for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2011 17:39:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111119051427.GB12471@elie.hsd1.il.comcast.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org, =?utf-8?B?TWlyb3PFgmF3?= Zalewski <miniopl@poczta.onet.pl>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>

On Fri, Nov 18, 2011 at 11:14:27PM -0600, Jonathan Nieder wrote:
> Hi Greg,
>=20
> Miros=C5=82aw Zalewski wrote[1]:
>=20
> > When kernel is invoked with ACPI support, it has various problems w=
ith USB=20
> > detection
> [...]
> > When finally booted, at least wireless driver (ath9k)=20
> > does not work. I heard that sound does not work as well, but haven'=
t=20
> > tested it myself. With ACPI enabled, kernel is unable to shutdown c=
omputer=20
> > properly.
> [...]
> > This is known flaw of Toshiba Satellite C650/kernel. You can find v=
arious=20
> > posts around the net about it.
> >
> > Toshiba Satellite C650 comes in four variants:
> > PSC08E
> > PSC10E
> > PSC12E
> > PSC14E
> [...]
> > In July there was a BIOS update for 12E and 14E. The new BIOS is ve=
rsion 1.5=20
> > and it is said to fix ACPI issues on Linux [3]. Unfortunetly there =
is no new=20
> > BIOS for 08E and 10E machines.
>=20
> Miros=C5=82aw confirmed that cherry-picking the following six patches=
 on top
> of your linux-2.6.32.y tree brings his machine back to sanity:
>=20
>  729df0f848da (ACPICA: Add detection of corrupted/replaced DSDT, 2010=
-04-01)
>  69ec87efa815 (ACPICA: Add subsystem option to force copy of DSDT to =
local
>   memory, 2010-04-01)
>  43323cb4c4b6 (ACPICA: Update DSDT copy/detection, 2010-04-07)
>  aa2110cb1a75 (ACPI: add boot option acpi=3Dcopy_dsdt to fix corrupt =
DSDT,
>   2010-04-08)
>  cce4f632db20 (ACPI: fix early DSDT dmi check warnings on ia64,
>   2010-05-12)
>  100cf87788c0 (ACPI: invoke DSDT corruption workaround on all Toshiba
>   Satellite, 2010-09-28)
>=20
> Patches 1-5/6 have been in Debian squeeze since last September and se=
em
> to work well.  Patch 6/6 turns on acpi=3Dcopy_dsdt by default for
> additional machines that need it, including Miros=C5=82aw's.

These all do not look like the match up with the stable_kernel_rules.tx=
t
file, do they?

Because of that, I can't take these patches, sorry.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
