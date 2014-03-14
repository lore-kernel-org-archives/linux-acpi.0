From: Valdis.Kletnieks@vt.edu
Subject: Re: ACPICA 20140214 auto-serialize weirds my machine...
Date: Fri, 14 Mar 2014 16:04:17 -0400
Message-ID: <22867.1394827457@turing-police.cc.vt.edu>
References: <14866.1394813101@turing-police.cc.vt.edu> <20140314173801.GA3755@kria>
            <94F2FBAB4432B54E8AACC7DFDE6C92E37C7F9876@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1394827457_1931P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:60249 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbaCNUE4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2014 16:04:56 -0400
In-Reply-To: Your message of "Fri, 14 Mar 2014 19:36:54 -0000."
             <94F2FBAB4432B54E8AACC7DFDE6C92E37C7F9876@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

--==_Exmh_1394827457_1931P
Content-Type: text/plain; charset=us-ascii

On Fri, 14 Mar 2014 19:36:54 -0000, "Moore, Robert" said:
> Sabrina, Valdis:
>
> Do either of you see any error messages like this:
>
> ACPI Error: Mutex [0x1] is not acquired, cannot release (20140214/utmutex-437)

All of my "ACPI Error:" messages look like either:

ACPI Error: Cannot acquire Mutex for method [SNVC], current SyncLevel is too large (1) (20140214/dsmethod-362)

or

ACPI Error: Method parse/execution failed [\ECBT] (Node ffff88012d02d588), AE_AML_MUTEX_ORDER (20140214/psparse-536)

I should have a git bisect finished shortly...

--==_Exmh_1394827457_1931P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBUyNgwQdmEQWDXROgAQI7xQ//fLsxlrk728VexAhHjoJ9XNiivRaDVP72
2XFb5cA/UKO5Yy7SUhP2uHEP0Ot+kmWrJHmPCXFKfrDh+moGVt7E0cTkck1GL7LY
o4WnNC2+O/JkedC6er0EiRyU5MHZXoaP48O1QwNQQmebSuWng6YQ235gS3iY2U1C
l33ITncJ3nITwEZHrK8ThcYhS2NVZhG70e6AQvALJR1bMU+TxLxmaCp1yr2h/Pxu
b31cVY8JKa7oFiHAQheinBH69XSo1F6KC2Q2EnSTUChf/KQ028YYPhvaKUve+P5S
u4vOmPM4LGoNglKvTt8ThV4UK8zb9bg0zzav0AZSAIslt8O8EZrCGKNbl85NA7k3
iYqgqEqcw5n6GtGx3MykilUdCI7ashxRoNnb3jaFP61mGhDQYv0r2qiW0mF2/DKG
oIOYAq5nridB2dsqBaFlwFRi9Ta7xzNzUhaplfR6BHcfNlMd1bjIAyoxMTMTIZ+8
Ru2A4D0TqDuT0lb80u8QaHrSSxAXHD7Z8E4ieSrVHj/ZC98YC9+B+Le2KK4ct97t
knM+fkEApDGXW+9xZK9t0N74bbeH7ZwOUDV5B0l0sALQP7y9hSxBDgpGG5QLBN0r
n9DhPotxUMFVfb9xp9Y3uzOy+QExcuU0vl+71cUVtaLs+MjF3z87+wWbEIUiPTWP
0MGy0B4hGy4=
=Ix/g
-----END PGP SIGNATURE-----

--==_Exmh_1394827457_1931P--
