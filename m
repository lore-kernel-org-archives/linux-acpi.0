From: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Subject: Re: [Pcihpd-discuss] [PATCH 2/7] acpiphp - remove init_slots()
Date: Fri, 20 Jan 2006 11:25:59 +0100
Message-ID: <200601201126.06541@bilbo.math.uni-mannheim.de>
References: <877j8vp5y4.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1951623.UNT2uWdESP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:18392 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750808AbWATK3f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 05:29:35 -0500
In-Reply-To: <877j8vp5y4.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net
Cc: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, greg@kroah.com, pavel@ucw.cz, kristen.c.accardi@intel.com, linux-acpi@vger.kernel.org, len.brown@intel.com

--nextPart1951623.UNT2uWdESP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

MUNEDA Takahiro wrote:

>+	slot = kmalloc(sizeof(struct slot), GFP_KERNEL);
>+	if (!slot)
>+		goto error;
>+	memset(slot, 0, sizeof(struct slot));

Use kzalloc() instead of kmalloc() and memset(). Use sizeof(*slot).

Eike

--nextPart1951623.UNT2uWdESP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBD0Lq+XKSJPmm5/E4RArq4AJwNIdUl/sA8YxaflqrRDkIyFq/7GgCgi4Nv
OOad2SoTuRLn7u8BvJQzhio=
=Vn2G
-----END PGP SIGNATURE-----

--nextPart1951623.UNT2uWdESP--
