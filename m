From: Valdis.Kletnieks@vt.edu
Subject: Re: on builds/randconfigs (was: [PATCH -next] thermal: depends on NET)
Date: Wed, 12 Jan 2011 17:15:40 -0500
Message-ID: <39920.1294870540@localhost>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au> <alpine.LFD.2.02.1101121257580.18873@x980> <20110112131800.d64c1a86.akpm@linux-foundation.org> <201101122224.54330.rjw@sisk.pl>
            <alpine.LFD.2.02.1101121654000.19754@x980>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1294870540_34736P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:59496 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1ALWSL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 17:18:11 -0500
In-Reply-To: Your message of "Wed, 12 Jan 2011 16:58:26 EST."
             <alpine.LFD.2.02.1101121654000.19754@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>

--==_Exmh_1294870540_34736P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 Jan 2011 16:58:26 EST, Len Brown said:

> Kconfig select needs to be fixed so that it is not possible to
> select something if that something's dependencies are not met.

Amen to that. Got bit by that in the CONFIG_XT_MATCH_REALM thread, it was
trying to do a select on NET_CLS_ROUTE, which depended on NET_SCHED which was
unset...


--==_Exmh_1294870540_34736P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNLigMcC3lWbTT17ARAt4+AJ4pH/LHguHhKwZ5ZJbNW6PgOaJSmQCeLPAe
5C5/Hireq204xQYUlpQgoKc=
=1Znu
-----END PGP SIGNATURE-----

--==_Exmh_1294870540_34736P--

