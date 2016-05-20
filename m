From: Valdis.Kletnieks@vt.edu
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Thu, 19 May 2016 23:05:00 -0400
Message-ID: <7208.1463713500@turing-police.cc.vt.edu>
References: <4736.1463510462@turing-police.cc.vt.edu> <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
 <6459.1463698397@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1463713500_6311P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41373 "EHLO
	omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753604AbcETDFJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2016 23:05:09 -0400
In-Reply-To: <6459.1463698397@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

--==_Exmh_1463713500_6311P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 May 2016 18:53:17 -0400, Valdis.Kletnieks@vt.edu said:

> > > next-20160512 sets the screen brightness to about 40%-ish or so, rather
> > > than the 100% intensity I want.

> Put this one in the "things that go bump in the night" pile - the problem
> doesn't manifest on next-20160519, even though the commit I bisected to
> is in the tree for today, and I don't see any obvious smoking guns to
> have fixed it in the past week's worth of 'git log'....

Actually, put it in "things that go bump in the night but need a stake driven
through them"- it looks like I booted the wrong kernel while testing, and in
fact next-20160519 *is* still broken.  However, after:

git revert -n e4f35c1339f0cfcf38d3f63dd6fea2b070399263
git revert -n 059500940defe285222d3b189b366dfe7f299cae

Things work again.

--==_Exmh_1463713500_6311P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVz5+3AdmEQWDXROgAQKXbBAAuXYtsXTHQyhvelOhWWtzjC0A8VeArVNX
Xw4pw1XKTn/+YQc1jPXhMp5Pjcx8J1blI+rsN2BCpn+P4Qn42vWhgPVpnoUot/43
XWWbei3+D5AQ5ub7mnbSkoA5X5Gm1dGqKmiu4zOHnnsDwUyo3orYUBAAJg47TSRB
uR1qd01m86UB7n2RQmvqjyDmYhGESrcJKO0zIQEPW7hTWek9AqePpXoc7a2BCJXZ
2Wj22ZnQHR/ng8vJ+iuOjlCyo5UC/SM26/a6565VxI9A8i2hODm9tW4+9AxwBkqL
pF2m7JPqcxEUd713O+egGqLEcJ8S3bGPopzSAW4pQP71iCWYmTBWa3yvFQoA4zRd
KNidRm8rVpqhyQXDxPtd8atKU3Wg+kTmK9v5mLI0mMpPqo/49k9pf8Rwbwx3URLT
zfLT8s5tOLeFmuBtKHM7RTDuZAUnGWNnpoIZgQGzjREe5PMP2jZyYEHuxGQB8vCt
hvAhqLUV0Q+YNBI7mC2X58ZPkDvu3mHo7od0YKl/APz2c7vajXZzqfDZWFdXdVPv
A+VdLgreF9LUcQnUD1uCC/IALF3r4XBdb7pkyz6a15sH+zRIA9FtDiREB/1zmhb5
ai8Gm2UCvM8gqJS2NhHkFnbh/GH1nZS1AagWJigwcSXKzUQkj5UdPlLyl4bd0dKp
ySkEAg3vi44=
=5GAv
-----END PGP SIGNATURE-----

--==_Exmh_1463713500_6311P--
