From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer Aspire 1511LMi - battery unreadable
Date: Tue, 15 Jun 2004 14:27:38 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0550115BEA0@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karl Vogel <karl.vogel-/1BeJOKqmzrQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Try using "External (name)" for each of the missing names.  They are
probably in another table (except for Z005).  The AML disassembler does
not automatically generate externals.



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karl Vogel
> Sent: Sunday, June 13, 2004 1:16 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Acer Aspire 1511LMi - battery unreadable
>=20
> Recently bought an acer notebook (Athlon64 w/ nVidia nForce3), but it
> seems
> that there are problems with the ACPI tables. I've been reading up on
the
> subject, but I'm unable to resolve the issue myself... so this is a
cry
> for
> help :-)
>=20
> When trying to read the battery status, I get the following kernel
> message:
>=20
> ---
>   psargs-0352: *** Error: Looking up [Z005] in namespace, AE_NOT_FOUND
> search_node c1521480 start_node c1521480 return_node 00000000
>  psparse-1133: *** Error: [NULL NAME], AE_NOT_FOUND
>  dswexec-0435 [225] ds_exec_end_op        : [Index]: Could not resolve
> operands, AE_NOT_FOUND
>  psparse-1133: *** Error: Method execution failed [\_SB_.BAT1._BST]
(Node
> c1520e80), AE_NOT_FOUND
> acpi_battery-0207 [217] acpi_battery_get_statu: Error evaluating _BST
> ---
>=20
>=20
> I tried patching the DSDT, but it doesn't cleanly compile with iasl.
The
> following errors occur:
>=20
> ---
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20040527 [Jun 11
2004]
> Copyright (C) 2000 - 2004 Intel Corporation
> Supports ACPI Specification Revision 2.0c
>=20
> DSDT.dsl  2406:                             If (LLess (\_PR.CPU0._PPC,
> Local1))
> Error    1022 -                               Object does not exist ^
> (\_PR.CPU0._PPC)
>=20
> DSDT.dsl  2408:                                 Store (Local1,
> \_PR.CPU0._PPC)
> Error    1022 -                                       Object does not
> exist ^
> (\_PR.CPU0._PPC)
>=20
> DSDT.dsl  2421:                                     If (LNot (LEqual
> (\_PR.CPU0._PPC, 0x00)))
> Error    1022 -                                              Object
does
> not
> exist ^  (\_PR.CPU0._PPC)
>=20
> DSDT.dsl  2423:                                         Store (0x00,
> \_PR.CPU0._PPC)
> Error    1022 -                                             Object
does
> not
> exist ^  (\_PR.CPU0._PPC)
>=20
> DSDT.dsl  3865:                     Method (DRUL, 1, NotSerialized)
> Warning  2019 -                                ^ Not all control paths
> return
> a value (DRUL)
>=20
> DSDT.dsl  5074:                 Z005,
> Error    1022 -                    ^ Object does not exist (Z005)
>=20
> DSDT.dsl  5075:                 Z005,
> Error    1022 -                    ^ Object does not exist (Z005)
>=20
> DSDT.dsl  5347:     Method (\_WAK, 1, NotSerialized)
> Warning  2026 -                 ^ Reserved method must return a value
> (_WAK)
>=20
> ASL Input:  DSDT.dsl - 5420 lines, 192635 bytes, 2606 keywords
> Compilation complete. 6 Errors, 2 Warnings, 0 Remarks, 644
Optimizations
> ---
>=20
>=20
> The Z005 is never used, but it is present in a definition:
>=20
>             Name (PBST, Package (0x04)
>             {
>                 0x00,
>                 Z005,
>                 Z005,
>                 0x2710
>             })
>=20
>=20
> I replaced those with 0x000 (not sure what the default value should
be, 0
> sounds logical).
>=20
> The _PPC error is something I don't know how to resolve. Code looks
like:
>=20
> -- usage code:
>                             If (LLess (\_PR.CPU0._PPC, Local1))
>                             {
>                                 Store (Local1, \_PR.CPU0._PPC)
>                                 Notify (\_PR.CPU0, 0x80)
>                                 Sleep (0x01F4)
>                             }
> ---
>=20
> -- definition
>     Scope (\_PR)
>     {
>         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>     }
> ---
>=20
> No _PPC here. I tried the following:
>=20
> ---
>     Scope (\_PR)
>     {
>         Processor (CPU0, 0x00, 0x00008010, 0x06) {
>         Name (_PPC, 0x00) }
>     }
> ---
>=20
> This I could compile, but my kernel crashed after this change.. so any
> ideas
> on how to fix this?!?
>=20
> The DSDT is 23kb, so I'll refrain from posting it. If anybody wants
it,
> just
> mail me directly.
>=20
>=20
> ACPI info:
>=20
> Jun 13 12:09:42 localhost kernel: ACPI: RSDP (v000
> PTLTD                                     ) @ 0x000f6ec0
> Jun 13 12:09:42 localhost kernel: ACPI: RSDT (v001 PTLTD    RSDT
> 0x06040000
> LTP 0x00000000) @ 0x1ff792fd
> Jun 13 12:09:42 localhost kernel: ACPI: FADT (v001 NVIDIA CK8
> 0x06040000
> PTL_ 0x000f4240) @ 0x1ff7ee3e
> Jun 13 12:09:42 localhost kernel: ACPI: MADT (v001 NVIDIA NV_APIC_
> 0x06040000
> LTP 0x00000000) @ 0x1ff7eeb2
> Jun 13 12:09:42 localhost kernel: ACPI: SSDT (v001 PTLTD  POWERNOW
> 0x06040000
> LTP 0x00000001) @ 0x1ff7ef02
> Jun 13 12:09:42 localhost kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$
> 0x06040000
> LTP 0x00000001) @ 0x1ff7efd8
> Jun 13 12:09:42 localhost kernel: ACPI: DSDT (v001 NVIDIA      CK8
> 0x06040000
> MSFT 0x0100000e) @ 0x00000000
>=20
>=20
> Regards,
> Karl
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the
> one installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
