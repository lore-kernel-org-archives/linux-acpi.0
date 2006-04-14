From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Power-button event after resume from S3
Date: Fri, 14 Apr 2006 15:33:32 +1000
Message-ID: <200604141533.40747.ncunningham@cyclades.com>
References: <E1FT8ip-00028X-00@skye.ra.phy.cam.ac.uk> <200604111414.59650.ncunningham@cyclades.com> <1144938518.1936.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2361262.0L3hUunO7A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:30167 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S965110AbWDNFfQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 01:35:16 -0400
In-Reply-To: <1144938518.1936.8.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felix Kuehling <fkuehlin@ati.com>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

--nextPart2361262.0L3hUunO7A
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 14 April 2006 00:28, Felix Kuehling wrote:
> On Tue, 2006-11-04 at 14:14 +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Tuesday 11 April 2006 12:35, Sanjoy Mahajan wrote:
> > > >  if(acpi_during_suspend_resume)
> > > >	don't generate power button event to confuse user space daemon
> > >
> > > This patch might be useful useful in setting and unsetting
> > > acpi_during_suspend_resume (and also using it, but you should ignore
> > > those as they are hacks for a different problem).  The equivalent
> > > variable in the patch below is acpi_in_suspend.
> >
> > If you want this to get wider testing, I'll be happy to include it in t=
he
> > Suspend2 patchset.
>
> Just to clarify, software suspend is not affected by this problem. Only
> S3, possibly S1 and maybe S4BIOS are affected, though I've never seen
> the latter on any real system.

Thanks. I still think it would be worth including, because Suspend2 (and no=
w=20
uswsusp, I believe) lets you choose what to do after writing the image. One=
=20
of the options is suspending to ram, so that you effectively get disk-backe=
d=20
suspend to ram. It might be useful in this situation.

Regards,

Nigel

--nextPart2361262.0L3hUunO7A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEPzQ0N0y+n1M3mo0RAvllAJ0Rci4lEeEFLsF8nank26N2f7sIzACgnu28
sIj0rqXPoE+hhdJz2QWR2bM=
=+5sp
-----END PGP SIGNATURE-----

--nextPart2361262.0L3hUunO7A--
