From: Valdis.Kletnieks@vt.edu
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Thu, 19 May 2016 18:53:17 -0400
Message-ID: <6459.1463698397@turing-police.cc.vt.edu>
References: <4736.1463510462@turing-police.cc.vt.edu>
 <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1463698397_4779P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59693 "EHLO
	omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754492AbcESWyY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2016 18:54:24 -0400
In-Reply-To: <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

--==_Exmh_1463698397_4779P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2016 22:50:11 +0200, "Rafael J. Wysocki" said:
> On Tue, May 17, 2016 at 8:41 PM, Valdis Kletnieks <Valdis.Kletnieks@vt.edu> wrote:
> > next-20160512 sets the screen brightness to about 40%-ish or so, rather
> > than the 100% intensity I want.
> >
> > Dell Latitude E6530 laptop.
> >
> > git bisect tells me:
> >
> > 059500940defe285222d3b189b366dfe7f299cae is the first bad commit
> > commit 059500940defe285222d3b189b366dfe7f299cae
> > Author: Aaron Lu <aaron.lu@intel.com>
> > Date:   Wed Apr 27 20:45:04 2016 +0800
> >
> >     ACPI/video: export acpi_video_get_levels
> >
> >     The acpi_video_get_levels is useful for other drivers, i.e. the
> >     to-be-added int3406 thermal driver, so export it.
> >
> >     Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > :040000 040000 24f4f5abe8beda2fa219dee7549faacc2f63e29fdfbe3a3bb4f58d82d5be768263d91172276fed98 M      drivers
> > :040000 040000 603ffbf36e76717fe4f4ecb0418c9dbc59c76e25a559bcd81c949a6471ffd045866df9b4e3fa4406 M      include
> >
> >
> > but I've stared at the code and don't see what would do this....
>
> Please try to check out the acpi-video branch from linux-pm.git and
> see if the problem is present then.  If it is, please revert all of
> the top-most commits up to and including the above one and see if the
> problem goes away.

Put this one in the "things that go bump in the night" pile - the problem
doesn't manifest on next-20160519, even though the commit I bisected to
is in the tree for today, and I don't see any obvious smoking guns to
have fixed it in the past week's worth of 'git log'....


--==_Exmh_1463698397_4779P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVz5D3QdmEQWDXROgAQKThhAAmnsmNyVQE54qPjnE2B3WrL5GzaTbKJQl
gZiz0ADzUi+h9Psq0gl1QaTk7pkx2M+zx/A2Ro8bj5N82ZPsrIM25H12b4WDuF4q
S1AgAkUJwPim+ugmifJDnExM9TQnnDPACwJ7xwy18Ez8UNx1o9i7rfVpQcwmVXzT
IiYf3WuURSScnyGP48RT/oPSHqtuL+fn6uq1gDuqkFJTkV9qRGsLW+jC2N8pmo1O
qPSxZ+6ahz4pgG/eF0dFrUHff0qYAhkDqZTOgoxd5hAq2Jzr/mEE0HmbOu5DN12e
qqQQYmK/FEFvasv/ro5fJ40SRLI0mNRBc0gNJ8sVDG9Ve8SWr8lQJJdvOZbs1sQ5
9Vtl75d8Ia3Y07891yevtypLFW6bPnT77ptL6IA6lDHjcpzIl0p0Y8Y2wEAQWKtA
bsEWzUTv8I6RzxeDVkAwoY97AJ6K0ZyWUeX17AU0wrwPMg1Elw/ZfSHGupt0xqVU
HSbdVbNfQNcPm4h7jTspdcZictlQQnMcEavZ77zKUIMjfh+RC05MqtrnoT/HZP7S
VndymoC36/fcvf59R5TN+eI08RGerWUwwLRxa5MmmxWkkv2/dcStWW5GHgSRXtQE
hh7Zs8LFW2Ulmnr23/rk/bCPiScAYDP4W1ve6FjFzgOU3IL8qTvW6NCS/zOLMWMr
VEYZdZr3DKI=
=FtiO
-----END PGP SIGNATURE-----

--==_Exmh_1463698397_4779P--
