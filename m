From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.2 ACPI problem
Date: 17 Feb 2004 01:05:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076997915.2510.15.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8C53@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E8C53-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Cc: Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Lenar,
Did this start in 2.6.2, or did it happen with previous kernels too?=20
Does it also happen in 2.6.3?

On Tue, 2004-02-10 at 09:33, Lenar L=F5hmus wrote:
> Hi,
>=20
> Having problems here with ACPI on Compaq Evo N610c laptop.
> Everything boots up fine except when loading battery module
> one gets this:
>=20
>     ACPI-1120: *** Error: Method execution failed
> [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40),
> AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed
> [\_SB_.C045.C059.C0E2.C14E] (Node c157bc40),
> AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed [\_SB_.C198._BTP]
> (Node c1577d20), AE_AML_UNINITIALIZED_LOCAL
> ACPI: Battery Slot [C198] (battery present)
> ACPI: Battery Slot [C199] (battery absent)
>=20
> Tried with and without RELAXED_AML.
>=20
> Now despite this machine seems to work fine until kde's laptop daemon
> does something I'm not aware of which results in
> these lines in dmesg:
>=20
> Feb 10 17:52:35 debian kernel:     ACPI-0245: *** Error: Cannot
> release
> Mutex [_GL_], not acquired
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C12C] (Node c157bf80),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C145] (Node c157bcc0),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C045.C059.C0E2.C14C] (Node c157bc60),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C14C] (Node c1577ee0),
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method
> execution failed [\_SB_.C198._BST] (Node c1577da0),
> AE_AML_MUTEX_NOT_ACQUIRED
>=20
> Aftwerwards whole KDE hangs (but that's probably KDE's problem) also
> trying to run 'acpi' on command line stalls and is not interruptible.
> Shutdown stalls do.
>=20
> Any solutions or something to try?

Well, to treat the symptom (and isolate the problem) see if things work
better when you disable the battery driver:

CONFIG_ACPI_BATTERY=3Dn

(or simply remove the battery driver under /lib/modules...)

cheers,
-Len






-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
