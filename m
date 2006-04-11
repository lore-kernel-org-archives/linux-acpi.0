From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Power-button event after resume from S3
Date: Tue, 11 Apr 2006 14:14:54 +1000
Message-ID: <200604111414.59650.ncunningham@cyclades.com>
References: <E1FT8ip-00028X-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2712596.tbmGcpMCHl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from b3162.static.pacific.net.au ([203.143.238.98]:21935 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750868AbWDKEQY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Apr 2006 00:16:24 -0400
In-Reply-To: <E1FT8ip-00028X-00@skye.ra.phy.cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Yu, Luming" <luming.yu@intel.com>, Felix Kuehling <fkuehlin@ati.com>, linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

--nextPart2712596.tbmGcpMCHl
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 11 April 2006 12:35, Sanjoy Mahajan wrote:
> >  if(acpi_during_suspend_resume)
> >	don't generate power button event to confuse user space daemon
>
> This patch might be useful useful in setting and unsetting
> acpi_during_suspend_resume (and also using it, but you should ignore
> those as they are hacks for a different problem).  The equivalent
> variable in the patch below is acpi_in_suspend.

If you want this to get wider testing, I'll be happy to include it in the=20
Suspend2 patchset.

Regards,

Nigel

--nextPart2712596.tbmGcpMCHl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEOy1DN0y+n1M3mo0RAjkUAJ0c/F73LyN+C3nTVDFoapTK7AlySACfRSu9
+t/fzkfVQoBYzjDtDk03mCk=
=CsX/
-----END PGP SIGNATURE-----

--nextPart2712596.tbmGcpMCHl--
