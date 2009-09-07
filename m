From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPI: Clarify resource conflict message
Date: Mon, 7 Sep 2009 15:36:46 +0200
Message-ID: <200909071536.46934.jdelvare@suse.de>
References: <200908301546.22827.jdelvare@suse.de> <9b2b86520908301410i31b69f71s27809788d3b1f103@mail.gmail.com> <alpine.LFD.2.00.0908311305110.19451@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48932 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbZIGNgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 09:36:45 -0400
In-Reply-To: <alpine.LFD.2.00.0908311305110.19451@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>

Hi Len,

Le lundi 31 ao=FBt 2009, Len Brown a =E9crit=A0:
> > > The message "ACPI: Device needs an ACPI driver" is misleading...
>=20
> > > ACPI: Device may still be supported by an ACPI driver
>=20
> > I would drop the word "still", but otherwise I think this is a good=
 idea.
>=20
> I agree we need to clarify this message.
>=20
> Right now we have (copied from a recent bug report):
>=20
> w83627ehf: Found W83627EHG chip at 0x290
> ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region=
 SEN1
> [0x295-0x296]
> ACPI: Device needs an ACPI driver
>=20
> This results in people filing bugs against ACPI because their sensor
> driver does not load -- we've seen several already.

I know, and this is why I sent a patch to change the wording.

> I'm okay with the 1st ACPI line -- it tells somebody who cares exactl=
y
> what is going on.
>=20
> "Device needs an ACPI driver", however, fails to tell the administrat=
or
> what they can do about it.  We should probably mention that they
> can test "acpi_enforce_resources=3Dlax".  However, we should probably
> put a big WARNING - using-at-own-risk note in the dmesg when
> that option is actually used.

I don't think we want to unconditionally point the user to
"acpi_enforce_resources=3Dlax". Doing so would essentially void our
effort to get rid of concurrent access to these resources.

In particular, now that we have the asus_atk0110 driver and this
driver loads automatically on the boards which need it, we certainly
do NOT want to tell these users that they should use
"acpi_enforce_resources=3Dlax". What they should do is use the
asus_atk0110 driver instead of the native driver they were using so
far.

Only if no ACPI-based hardware monitoring driver has been loaded, we
could point the user to "acpi_enforce_resources=3Dlax". With a warning
and disclaimer, of course.

> And then what is the next course of action -- possible inclusion
> on a white-list if they conflict turns out to be benign,
> or (less likely) possible development of a missing ACPI driver?

I wasn't sure whether you would be OK with a whitelist. I too
think we will need one, although this won't be in 2.6.31. Then it
indeed makes sense to ask the users to test
"acpi_enforce_resources=3Dlax", and if it works, they can report to us
and after a DSDT code review, their system can be added to the
whitelist.

I am curious how many systems will have to be added to the whitelist.
I presume that the whitelist would consist in DMI board vendor +
model entries?

> We could have quite a few bug reports filed on this,
> so wording is important.

I fully agree.

What I propose:
* For 2.6.30 (if we are fast enough), an updated version of my patch,
  taking Alan Jenkins' suggestion into account, and an additional
  warning when "acpi_enforce_resources=3Dlax" is used.
* For 2.6.31, a whitelisting mechanism, and a verbose log message
  explaining the steps to get a system into this whitelist.

OK?

Thanks,
--=20
Jean Delvare
Suse L3
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
