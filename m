From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:18:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103231846.D19750@brodo.de>
References: <20021103220251.GC28704@atrey.karlin.mff.cuni.cz> <000301c28385$b68eb510$c200a8c0@pikachu> <20021103221143.GF28704@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103221143.GF28704-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>; from pavel-+ZI9xUNit7I@public.gmane.org on Sun, Nov 03, 2002 at 11:11:43PM +0100
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

Hi!

On Sun, Nov 03, 2002 at 11:11:43PM +0100, Pavel Machek wrote:
> > My point is more that it might be better to assume that things won't
> > work.  This isn't a sound driver.  This is something that the life of
> > the computer depends on, and if somebody's processor melts down becau=
se
> > they didn't read some piece of kernel documentation that they didn't
> > even know existed, they're not likely to be particularly forgiving an=
d
> > think "Oh, it was my fault for not realising that my hardware was
> > broken, I'll be more careful next time".
>=20
> No. Worst that can happen is that your machine powers off. And thats
> after machine already has at least one hardware bug.

Actually, I doubt that it will power off. Assume your BIOS vendor set
critical to 110=B0C (my vendor did so). And the CPU burns through at 70=B0=
C.
Let's assume no thermal management objects like fans exist. Without custo=
m
polling, a trip point of 65=B0C for critical has no, really no effect. Th=
e
CPU melts down. Or am I missing something?

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
