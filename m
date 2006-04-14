From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Hibernate
Date: Fri, 14 Apr 2006 14:31:45 +1000
Message-ID: <200604141431.50491.ncunningham@cyclades.com>
References: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com> <200604132126.42755.ncunningham@cyclades.com> <1144983375.2865.73.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1876207.dNlPS4c2tD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:29832 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S965064AbWDNEd0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 00:33:26 -0400
In-Reply-To: <1144983375.2865.73.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@l-3com.com>, linux-acpi@vger.kernel.org

--nextPart1876207.dNlPS4c2tD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 14 April 2006 12:56, Shaohua Li wrote:
> On Thu, 2006-04-13 at 19:26 +0800, Nigel Cunningham wrote:
> > Hi Allan.
> >
> > On Wednesday 12 April 2006 22:50, Cleaveland, AJ Allan @ IS wrote:
> > > I'm trying to get hibernate to work on CentOS 4.  What I really want =
to
> > > do is use hibernate to start-up the machine every time.  To do this I
> > > would create an "image" to come out of hibernate with and set the
> > > machine to always think it's coming out of hibernate, no matter how it
> > > was actually shut down.  It would always use my "image", even if it w=
as
> > > placed in hibernate when it shut down.  Without rewriting other
> > > people's code does anyone know of a way to do this?
> > >
> > > Thank you,
> > > Allan
> >
> > I'm not sure I understand what you're saying correctly, but it sounds to
> > me like you want something like the KeepImage feature in Suspend2. This
> > feature lets you suspend once, and subsequently simply powerdown rather
> > than rewriting the image. To use this mode reliably, any filesystems
> > mounted when the image is created have to be immutable. This is because
> > the image will include information about the filesystems such as
> > superblocks, inodes, dentries and so on, and these data structures must
> > match the data on disk.
>
> We could have file in memory for the snapshot kernel before we mount any
> hardisk filesystem, and then create a new initrd including the snapshot
> image after boot. Later we always use the new initrd. This way even the
> hardisk is touched, the kernel can still resume.

Yes. I've been thinking about this for a while, and planned to work on it t=
o=20
reduce the boot time of some of our Cyclades products. In fact, I was=20
thinking about making the initrd be the image (using code I already have in=
=20
the filewriter to do this).

Regards,

Nigel

--nextPart1876207.dNlPS4c2tD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEPyW2N0y+n1M3mo0RAip4AJ9Mm2ArkGsVSd9fOdmT8AeTxBgI2gCbBx5Z
x2gEReaHgXJUEeqKywjuttA=
=6hA6
-----END PGP SIGNATURE-----

--nextPart1876207.dNlPS4c2tD--
