From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [Swsusp-devel] ACPI A/C adaptor status not updated upon resume
Date: Fri, 18 Jul 2003 16:53:22 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE9D@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ka-shu Wong <kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, EricAltendorf-gZ4DH+Stb0k@public.gmane.org, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Ka-shu Wong [mailto:kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org]=20
> Has there been any progress on this issue?
>=20
> I'm running kernel 2.4.21 with acpi-20030619 and swsusp-1.0.2 on my
> toshiba portege 2000, and I'm getting the same problem.
>=20
> Disassembling the _PSR method gives:
>=20
> 000031bd:     Method _PSR (\_SB_.ADP1._PSR)
> 000031c3:       ArgCount 0; NotSerialized
> 000031c4:       Return
> 000031c5:         \_SB_.MEM_.ACST (000002da)
>=20
> It seems that it is storing its state somewhere and changing it based
> on events.  Software suspend is probably saving this state=20
> and restoring
> it upon resume.

See, now your system is different from Eric's, which looks like this:
        Device (MEM) {
            OperationRegion (SRAM, SystemMemory, 0x000EE800, 0x1800)
            Field (SRAM, AnyAcc, NoLock, Preserve)
            {
 		...
                Offset (0xFF),=20
                ACST,   1,=20
		...
		}

            Method (_PSR, 0, NotSerialized)
            {
                Return (\_SB.MEM.ACST)
            }

So, all his _PSR does is check a bit in system memory, whereas yours
calls another control method, so I don't know what your machine does
from there. Can you go look?

Basically, I am at a loss as to why Eric's machine would report the
wrong thing. Whoever is setting that bit in memory isn't doing it
properly, for some reason. (There could be a lot of reasons. Eric, you
might try sticking a printk in the memory read function in
drivers/acpi/osl.c and seeing that we are doing a read from 0x000EE8FF
and what the value is.)

Regards -- Andy

PS if you're curious the EE8FF is because the SRAM operation region is
defined as a memory range starting at 0xEE800, and ACST is a field
offset 0xFF bytes from that.
PPS if you look at the E820 map on bootup, this should be in reserved
space.
PPPS ok that's it everyone have a great weekend! ;-)


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
