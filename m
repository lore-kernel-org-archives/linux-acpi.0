From: Jan Slezak <jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org>
Subject: ACPI DSDT language
Date: Tue, 28 Jan 2003 11:47:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301281147.03925.jan.slezak@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I would like to know what way should be buffers handled when are passed a=
s arguments to=20
ACPI methods. I don't have a time to read the ACPI specs so I hope someon=
e knows.=20

I find out by tracing my /_TZ/TMP method that they are passed by value so=
 following=20
construction (part of my original DSDT slightly modified) doesn't work (P=
NPG called)=20
because PGET is not modified:

    Method (SX33, 2, NotSerialized)
    {
        If (LLess (Arg1, SizeOf (Arg0)))
        {
            CreateByteField (Arg0, Arg1, SX20)
            Store (Something, SX20)
        }
    }

    Method (PNPG, 1, NotSerialized)
    {
=09.
=09.
        Name (PGET, Buffer (8) {})
        SX33 (PGET, 2)
        Return (PGET)
    }

I need to know it to decide wheter it is my BIOS or the linux ACPI implem=
entation what is=20
buggy and to decide whether to send my DSDT patch to my notebook manufact=
urer (DELL).


Thanks,
  Jan

P.S.: If it is right behaviour and the BIOS is buggy I don't understand w=
hy the ACPI=20
(actually ACPI battery info) is working under WinXP, where there is no DS=
DT override and=20
no buggy feature workaround in the biosinfo.inf for my DELL.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
