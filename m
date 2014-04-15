From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Tue, 15 Apr 2014 05:24:42 -0400
Message-ID: <20140415092442.GC29868@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140414140514.GD3663@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46963 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbaDOJu4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2014 05:50:56 -0400
Content-Disposition: inline
In-Reply-To: <20140414140514.GD3663@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 04:05:14PM +0200, Borislav Petkov wrote:
> Date: Mon, 14 Apr 2014 16:05:14 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org,
>  linux-acpi@vger.kernel.org, arozansk@redhat.com
> Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Mon, Apr 14, 2014 at 03:39:24PM +0200, Borislav Petkov wrote:
> > Definitely a bad idea to export a spinlock. If all you need is to sync
> > against multiple callers of cper_mem_err_location(), simply grab that
> > spinlock in the function itself, without exporting it.
> >=20
> > > +
> > > +static char mem_location[CPER_REC_LEN];
> > > +static char dimm_location[CPER_REC_LEN];
>=20
> In thinking about this more, even with the proper synchronization,
> cper_dimm_err_location() returns a pointer to this dimm_location string.
> Now, imagine what happens if another caller grabs the lock and enters
> cper_dimm_err_location() while dimm_location is still being accessed by
> the tracepoint or the previous caller of cper_dimm_err_location...
>=20
> IOW, you either need a synchronization at a higher level so that dumping
> of dimm locations can be serialized or the higher callers (interrupt
> handlers, etc) already give you that synchronization.
That's why I export this spinlock because in another patch(3/5) I use
this spinlock to surround whole handling procedure of tracepoint.

If exporting this spinlock directly is too ugly, I can use an inline
function to get the same purpose.

>=20
> So you have to think about all possible call paths ending here and
> *then* introduce proper sync.
>=20
> Oh, and saying "No functional changes." in the commit message is a bit
> misleading, don't you think?
OK. Looks like this is not the 1st time you remind me not using so-called
"No functional change" :-). I have a different definition for functional
change ;-). It seems that I need to align my standard with you guys.

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTTPraAAoJEI01n1+kOSLH/1IQAIXrA3id97NhnH/wjVIdLJUN
EaC7ZgQAzbPB7P+UwRx0ZIOpxMXfEm91fcvTVnFRT15eQdqicxd78HpG7fEerjCM
NaS5rfwHLTLXRDeb1NW/w94ld5nanrIxUWpFbCVcPDeR1RfDBchRofQYleA5RIik
Z1quo7zXetWJ76ea/GzVp65ddZzeesq0b4mM2YiKz/5rK1fJzUajqqe1UFGlPhVj
8Y+nBzlXbmRas3XR9JYaROInFbtMPk6lQ5I6Ut0kUhoq+vp/4azUo0rsLGz095rz
I878QtscRSUDDe9FFgjEBUXM46fiNx/TyobgHFAja3ouFoSdQYHhQLm9RAgyTgPt
4bia2wHxKn1P7zUEmroMZxHOhDycbAyxe/iZnkDQXu2ykbR/h5M7+4jKy5I2hNXv
nW1Hv/7yGYcPObHdrSypiDwm3EsCjEUzX1zrc0I1Y51/3uqyb9AZQHF/SDWuoQqw
VVVfNZ0M9LnQHLkCa8v+jxLNHW4L1k6p8qvJmsoLlzwHJ1SHX7qBj0rgUl2FCTIs
XWZczBKBZar6dLqYaVJMnqbjOpMFwt848wEL5G84yUHDNM/Ynkyt5ZJFzS/gUtII
zS1H7gfsR99lkbaX0zYQGSZI0toS/rmMJ3KH+DjMPlLc+V8mkpI+57yFZNzdGq11
sR/x2LQgiOvNFz8LghUp
=LuLt
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
