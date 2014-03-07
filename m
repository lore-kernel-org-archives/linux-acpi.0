From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Fri, 07 Mar 2014 06:08:35 -0300
Message-ID: <20140307060835.4a094870@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
 <20140306111852.GA24629@pd.tnic> <20140306084320.539ec76e@samsung.com>
 <20140306121714.GC24629@pd.tnic> <20140306100653.46249ea1@samsung.com>
 <20140306152633.GE24629@pd.tnic> <20140306123915.0bae1252@samsung.com>
 <20140307062154.GA19240@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Emm1cU+Pjr.Qtgp2b2g7pRB"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:45417 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaCGJIy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Mar 2014 04:08:54 -0500
Received: from uscpsbgm1.samsung.com
 (u114.gpu85.samsung.co.kr [203.254.195.114]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2200A536QS1WA0@mailout1.w2.samsung.com> for
 linux-acpi@vger.kernel.org; Fri, 07 Mar 2014 04:08:52 -0500 (EST)
In-reply-to: <20140307062154.GA19240@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

--Sig_/Emm1cU+Pjr.Qtgp2b2g7pRB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Fri, 07 Mar 2014 01:21:54 -0500
"Chen, Gong" <gong.chen@linux.intel.com> escreveu:

> On Thu, Mar 06, 2014 at 12:39:15PM -0300, Mauro Carvalho Chehab wrote:
> > Date: Thu, 06 Mar 2014 12:39:15 -0300
> > From: Mauro Carvalho Chehab <m.chehab@samsung.com>
> > To: Borislav Petkov <bp@alien8.de>
> > Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com,
> >  arozansk@redhat.com, linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
> > X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.22; x86_64-redhat-linux-gnu)
> >=20
> > Em Thu, 06 Mar 2014 16:26:33 +0100
> > Borislav Petkov <bp@alien8.de> escreveu:
> >=20
> > > On Thu, Mar 06, 2014 at 10:06:53AM -0300, Mauro Carvalho Chehab wrote:
> > > > For example PCIe and memory errors are not x86-specific. Also, as A=
CPI=20
> > > > may also be used on ARM, we may also start to have APEI errors ther=
e:
> > > > 	https://lwn.net/Articles/574439/
> > > > 	https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI
> > > >=20
> > > > So, better to think on that on a long term.
> > >=20
> > > kernel/ras/ could also be used in that case but I guess drivers/ras/ =
is
> > > fine too.
> >=20
> > Both work for me, although drivers/ras seems more adequate, IMHO,
> > as I expect that we'll have there both subsystem code and drivers.
> >=20
> OK, I will move this trace stub to drivers/ras in next version.

Thanks!

> BTW, any other comments for 2nd patch? I thought Mauro will
> have some comments for that patch. :-)

Well, the comment is the same: I still think that the better would be
to map this via EDAC, in order to allow userspace to associate the DIMM
labels with the DIMMs that would be reported, as the association of
card, module, rank number, valid device into the corresponding DIMM
slot, as marked at the board's silkscreen is not trivial.

If you're not willing to do that, the better would then to add such
association logic inside the rasdaemon. Patches are welcomed.

Regards,
Mauro

--Sig_/Emm1cU+Pjr.Qtgp2b2g7pRB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGYyfAAoJEAhfPr2O5OEV0GAP/jd/c2SxoVriiaSEGqdOd+/h
3bHCnawYWWk1m+3d+Jnf3XNL4YywlfISaQqW6QXk/Ucq0O/cKJpGixpsj/d49SJx
ityxlrF8o1ua6cUzMxy+9oWoKQQq8vwd4UG0o4wxgBoq2T/MJneVV+s9I6msWGHA
fFd7JbsOBA2jNKWM3EnJdi+fgh0CFQIIJb23Ei6ZHzf7cX+3/5QlkcoTpBFBDGI+
7hKOCZF4mGKnc4ldzwDqXImQ2rC3ETxlPzRTsXtS08fY2SAgycHPvSVGgfnF9fPS
Z/uyrFwDxNHDhOjAh1P7VS2tWYa1/vV441aef4Y6iaoGKbtruRbH3t9tKwukINap
2p7ov58RUG5oJWlXoSFF6kjx/l3qqR4VwUIycYgqkO7KLMKM/BXp0u/bVPXEM9KP
ssoBSfrOkicqwxGtycYIAJRxLvCUp4BjQg+rBazQV4YkmDXwASMkz3f6EUBo7bE2
dmZmwFSAJPjjZuBwShJF3MEOGKcdpJI/OHqDfWh3qSskQODBys8wwePlYrSJ3uPp
D1zPElw7RIyTZqPu0mFjLzPuU/L0tColC9JEUApO2E7EPUUGyDOmJh5mpnzj7Csy
YAG8KTQXUj5ExyRIfTv8Ca2vjlSFwdhUS0g19USg25uKFTu6JpOF1AOyzIPZiQ0Z
YmbNXszIeii9eAdDsPPa
=+V9T
-----END PGP SIGNATURE-----

--Sig_/Emm1cU+Pjr.Qtgp2b2g7pRB--
