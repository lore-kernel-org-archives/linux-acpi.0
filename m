From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/5] trace, RAS: Add basic RAS trace event
Date: Sun, 13 Apr 2014 23:20:58 -0400
Message-ID: <20140414032058.GA22584@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
 <20140409194654.GR6529@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaDNDps (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Apr 2014 23:45:48 -0400
Content-Disposition: inline
In-Reply-To: <20140409194654.GR6529@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2014 at 09:46:54PM +0200, Borislav Petkov wrote:
[...]
>=20
> This should actually be
>=20
> menuconfig RAS
> 	bool "Reliability, Availability, Serviceability features"
> 	help
> 	  <A nice text about what this is going to contain, i.e. RAS stuff
>=20
> 	  ...
>=20
> if RAS
> config RAS_TRACE
> 	def_bool y
> 	depends on ...
>=20
> See drivers/edac/Kconfig for an example.
I don't use a explicit menu for RAS because I'm not sure if it is worth
to add such a *heavy hammer* in the kernel tree. Since you suggest it,
it is fine to me.

>=20
> RAS_TRACE should actually depend on all the code that uses it, or, it
> should be selected by them. EDAC_MM_EDAC is not accurate enough and will
> enable RAS_TRACE even for drivers which don't use the tracepoint(s).
Maybe some drivers don't call trace_mc_event directly/indirectly, but
edac_mc.c is the core of EDAC and must exist before any other drivers
are loaded, which means whether the drivers call trace_mc_event or not,
the trace interface in edac_mc should be there in advance. Do I miss
something?

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTS1QaAAoJEI01n1+kOSLHz7wQAI/blzVN9nHMQ0nrnEJk5s0M
zWW2Ku3t0GWYPmahy6ylMI6oTxnPTr5K3Zzxk4jQlk4iesbTGXJvSqr68w2qRirq
K+wj2j6GmYFHC6JGfqglKw+L0sUFydjwLvF3yGXzhkfyNzeBo2KqOnGf3acjajH1
lHyb/td2DM7+BIG8V8dTCEzCD8f0ZQMS/y+/y5T0ZBGMLOla7wbT2FxJFC7lN/Wz
KluFBYNOPcTFnwxqvcomSPTntoqKo0z3NX8WEL+d3v2ADwXP6gavzhT394pw/g4k
n3O/Hn43+CLPd6cB/z7tQJdeA6AGbxIjprzKE3xjqI0UJDSOw1vNd6vqbSxQHsSC
IPH4MeRLe8S/oTblYwWl7XHws5iBChq038VDLjQGX8li3nwMOrBMk9M6VXSwPMXF
grT33lw9K9z71UxDTSBJxmU905v9fcO+bwMUFp6ZuWfFYPlE36y0SYYDMCR5Psy3
OLuMB7eHXIEOLOKu7Y+6nrWai6v/0pxPVnswSl33G+8TE5qcwcRek+OCqntu/Hd1
mJnySrvVKSUgml19I9fjJYs/3XlLICBhV3JO0Azj5ioJXgJnlzvlNG8ZHsZOmLRz
DtZX1e+gf7U/GVGLcciJbJtkkX2ZsJ8eE0Oxb0CkA/uKZKxAFqYSB9F/l/wxT1os
qgFNf6/pRFG24sGRdDUz
=vkI0
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
