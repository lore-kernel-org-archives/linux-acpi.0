From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:29:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103232941.F19750@brodo.de>
References: <20021103220251.GC28704@atrey.karlin.mff.cuni.cz> <000301c28385$b68eb510$c200a8c0@pikachu> <20021103221143.GF28704@atrey.karlin.mff.cuni.cz> <20021103231846.D19750@brodo.de> <20021103222222.GJ28704@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103222222.GJ28704-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>; from pavel-+ZI9xUNit7I@public.gmane.org on Sun, Nov 03, 2002 at 11:22:22PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Sun, Nov 03, 2002 at 11:22:22PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > Actually, I doubt that it will power off. Assume your BIOS vendor set
> > critical to 110=B0C (my vendor did so). And the CPU burns through at =
70=B0C.
> > Let's assume no thermal management objects like fans exist. Without c=
ustom
> > polling, a trip point of 65=B0C for critical has no, really no effect=
. The
> > CPU melts down. Or am I missing something?
>=20
> Yes, you are missing reality.
>=20
> Try stopping your fan and see what happens. I believe you'll see your
> notebook powering off itself at <90C, low enough to keep cpu alive.

I hope that such a safeguard is present. But I don't know it. And I won't
test it. Better be safe than sorry.=20

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
