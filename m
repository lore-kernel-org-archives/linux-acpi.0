From: Christian Trefzer <ctrefzer@gmx.de>
Subject: Re: [patch 2/3] acpiphp: use new dock driver
Date: Thu, 13 Apr 2006 01:16:41 +0200
Message-ID: <20060412231641.GA28049@zeus.uziel.local>
References: <20060412221027.472109000@intel.com> <1144880325.11215.45.camel@whizzy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:22157 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932396AbWDLXQt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Apr 2006 19:16:49 -0400
Content-Disposition: inline
In-Reply-To: <1144880325.11215.45.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, mochel@linux.intel.com, arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi Kristen,

wanted to try this one out on my Dell Latitude CPiA and C/Dock II, but
something seems to have happened to the patch along the way:

Applying 'acpiphp: use new dock driver'

fatal: corrupt patch at line 206
Patch failed at 0002.

I tried looking at the patch itself and found nothing obvious. Also,
patching manually resulted in the same behaviour. Is this just me?

Sorry for the noise, but I'm dying to try this one out : )

Kind regards,
Chris

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRD2KWV2m8MprmeOlAQKNMxAAhuo7jLtnoiKkz6iHcOKCG0k4/TShBns6
d+h2278gc/+z3VWdrdQ32pJdp4Z8mA10/VrdokwLGm14E9lN9XQlRRcUb1JONB6i
MTGD8y7MB1Yvu17jbw+kJsz0Tndm4TPcpHcduCfJ+ggAd+1Sf18WcPq+SvBaDP97
86bomvrL9SX8Zvrpg7IuaXusVJBdY3wUQi0j+XQvy5JgVYvwCX2mdR1IyZHZxOSo
kODGHn33396+hV35uqz/O4kIYyvYUt3M1qvNecVwf8OYwjGJ0LlbjffyccYaZB8T
C69tk+FTVsGiOCccekfPhVHN/Uy0B2AReXAfUdrCOn5pohdIDQ4AuUsbbs2LvH28
UEiTNMHwh1wMz1zT/mSl373xb/grImbYec1sEQ23va0fqIjNaX2OXsf2TgI85tqn
y5T2z6JxHLnJDIbt031kP+U5SZpRYaNNrlgFtEZdrFNP840xpCpVBiryn2gJgL2z
tApLVHM+nK7ZBZc6IReRVa+YBfr4FUUIDljLa8Z8PXxeCzQGgFN3KnducOXW8HZ8
wmNSKT2YrtKdLTxVcq1AaQ3o7f+4B/Fl87uDWd1+7Uw9ZqwTXMbzDSLTjuGdUwsc
kC5oDqKiiPWQF261Z0afoFaOKEJPGklnn2/jgr4sNnrf+YvIsRrBnl/c/Z+yfNgm
dkqQGnE4fn8=
=qT6V
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

