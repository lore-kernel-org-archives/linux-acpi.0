From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v2 0/3] ACPI / button: Clarify initial lid state
Date: Fri, 27 May 2016 18:10:40 -0400
Message-ID: <20519.1464387040@turing-police.cc.vt.edu>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
 <cover.1464332745.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1464387040_2039P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48563 "EHLO
	omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753979AbcE0WKq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 18:10:46 -0400
In-Reply-To: <cover.1464332745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--==_Exmh_1464387040_2039P
Content-Type: text/plain; charset=us-ascii

On Fri, 27 May 2016 15:15:43 +0800, Lv Zheng said:
> The initial _LID returning value is not reliable after boot/resume because
> the BIOS vendors may implement it by returning a cached value that is only
> updated when a lid notification is received.
> This causes strange things happening after resuming. This patchset fixes
> the issue according to this fact.
>
> Lv Zheng (3):
>   ACPI / button: Remove initial lid state notification
>   ACPI / button: Refactor functions to eliminate redundant code
>   ACPI / button: Send "open" state after boot/resume

If it sends an "open" status, what happens if the machine was in fact
suspended with lid open, but is then resumed in a dock with an external
monitor?

(I'd test it myself, but I don't have suspend/resume configured on my laptop)

--==_Exmh_1464387040_2039P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBV0jF4AdmEQWDXROgAQL7NxAAgS4X/5ldGhTQKm2ixnmysDZ+LNUbjl5U
0f+5cndPl40kqsSitrWg3vlQHPem9P/4eHmyqBCEkAOGpwptQOuMsXfPaLYfYOMU
8d8Xayqwrsq0+yFQi7F5ugR5BIB2TPpfTB0uAWdKs6SXDlVOzHpDPXgsSJxL3jf/
OJYtug/xFWWUlol3VtKYDSCem0a3uXnicEN/Goun41aIz4gxmVpiTcFK3tR1fwXm
UyJduzn4UW2W7j8mlvT0o99fFmrzXp0VjhTln0WncaDtx3W7+m+sSCdLWUL31Brf
173RKECNtt3VDUXev2Iu3l+NgTK0DwhqQIIISiroh3ruVXJTO+f12wVrhq3et3oX
bMHNnwWH/minPMMQA5/3mkUHX+xvWsKXJ78lfH+Jy+L0x34Sgc7RBbFPhEhmArLG
OLk7T9rZHFqo7RdWK9IMAl4z5KmE2U3JEF42EAhSu14eRzlzSibdzljGcFLDG1KV
buOWIoUKVb3U/O2JSG0Lfryrd6BMWWMzKCc01t0704EuAg4fhKRZULVLYBYBBM/n
ycvjrH9Uqba9Qe7r9gfepIzAx4L/BMxWzb5IeajrSUtKxMSRXxcYjXV238nlDO2s
BTxo//wqpMDDx/ceiNiIzOv1dHCun4+7XVyNIEGYTIZYrQc/mits8nCg98/IGbAZ
BwB9Q/28dU4=
=VPwb
-----END PGP SIGNATURE-----

--==_Exmh_1464387040_2039P--
