From: Kjartan Maraas <kmaraas-gyXR7Lt7FVk/G1V5fR+Y7Q@public.gmane.org>
Subject: Re: 2.6.2 ACPI problem
Date: Wed, 18 Feb 2004 13:54:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077108844.7141.12.camel@localhost.localdomain>
References: <4028EBC3.6090002@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4028EBC3.6090002-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Cc: Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

tir, 10.02.2004 kl. 16.33 +0200, skrev Lenar L=F5hmus:

> Hi,
>=20
> Having problems here with ACPI on Compaq Evo N610c laptop.
> Everything boots up fine except when loading battery module
> one gets this:
>=20
>     ACPI-1120: *** Error: Method execution failed=20
> [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed=20
> [\_SB_.C045.C059.C0E2.C14E] (Node c157bc40), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed [\_SB_.C198._BTP]=20
> (Node c1577d20), AE_AML_UNINITIALIZED_LOCAL
> ACPI: Battery Slot [C198] (battery present)
> ACPI: Battery Slot [C199] (battery absent)
>=20
Seeing this exact same output on a N600c laptop here.

> Tried with and without RELAXED_AML.
>=20
> Now despite this machine seems to work fine until kde's laptop daemon=20
> does something I'm not aware of which results in
> these lines in dmesg:
>=20
> Feb 10 17:52:35 debian kernel:     ACPI-0245: *** Error: Cannot release=20
> Mutex [_GL_], not acquired
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method=20
> execution failed [\_SB_.C045.C059.C0E2.C12C] (Node c157bf80),=20
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method=20
> execution failed [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40),=20
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method=20
> execution failed [\_SB_.C045.C059.C0E2.C145] (Node c157bcc0),=20
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method=20
> execution failed [\_SB_.C045.C059.C0E2.C14C] (Node c157bc60),=20
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method=20
> execution failed [\_SB_.C14C] (Node c1577ee0), AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method=20
> execution failed [\_SB_.C198._BST] (Node c1577da0),=20
> AE_AML_MUTEX_NOT_ACQUIRED
>=20
I also saw these with GNOME until the battery status applet was fixed.

See http://bugzilla.gnome.org/show_bug.cgi?id=3D129167 for the relevant
fix for battstat. Maybe this fix shows a similar fix is possible under
KDE? Not sure this is a fix really, but at least the symptoms went away
for me after this got fixed.

Cheers
Kjartan


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
