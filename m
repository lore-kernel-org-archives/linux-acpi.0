From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: No Thermal Zone with a Sager NP3760 (Clevo M375E/M375W) and kernel 2.6.9 (DSDT available)
Date: Mon, 25 Oct 2004 10:23:58 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <9DE394C12A921946AEECE1F71944ECD57295D7@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Ale <patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Patrick Ale wrote:
> Hi,
>=20
> I have an equal-ish problem with my Acer Aspire 1703SM.
> Before using the DSDT for the Aspire 1703SC I had thermal support but
> no battery support.
>=20
> After I that I have battery support and all but the kernel tells me
> happely that my temperature is critical.... as in.. 255 degrees
> Celcius.. somehow I dont believe him ;-)
>=20
> Any idea what might cause this error?

It should have been fixed since 2.6.9 kernel, have you tried latest
kernel?

>=20
>=20
> On Fri, 22 Oct 2004 14:51:22 +0100, Bradley Chapman
> <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:=20
>>=20
>>=20
>> (Please CC me, I am not a member of the list)
>>=20
>> Thermal zoning is not detected by the stock ACPI code in 2.6.9 on my
>> Sager NP3760 laptop (a rebranded Clevo M375E or M375W, IIRC). iasl
>> 20040918 spits out these errors when attempting to compile the
>> decompiled DSDT:
>>=20
>> # iasl -tc dsdt.dsl
>>=20
>> Intel ACPI Component Architecture
>> ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18
>> 2003] Copyright (C) 2000 - 2003 Intel Corporation
>> Supports ACPI Specification Revision 2.0b
>>=20
>> dsdt.dsl    22:             Method (_PPC, 0, NotSerialized)
>> Warning  2019 -                        ^ Not all control paths return
>> a value (_PPC)
>>=20
>> dsdt.dsl    22:             Method (_PPC, 0, NotSerialized)
>> Warning  2026 -                        ^ Reserved method must return
>> a=20
>> value (_PPC)
>>=20
>> dsdt.dsl   201:             Method (_PSS, 0, NotSerialized)
>> Warning  2019 -                        ^ Not all control paths return
>> a value (_PSS)
>>=20
>> dsdt.dsl   201:             Method (_PSS, 0, NotSerialized)
>> Warning  2026 -                        ^ Reserved method must return
>> a=20
>> value (_PSS)
>>=20
>> dsdt.dsl  1081:     Method (SBWB, 3, NotSerialized)
>> Warning  2019 -                ^ Not all control paths return a
>> value (SBWB)=20
>>=20
>> dsdt.dsl  1762:             Field (SMRM, DWordAcc, NoLock, Preserve)
>> Error    1047 -                       ^ Access width is greater than
>> region size dsdt.dsl  1765:                 GSRM,   1,
>> Error    1051 -                    ^ Access width of Field Unit
>> extends beyond region limit
>>=20
>> dsdt.dsl  1766:                 DLCK,   1,
>> Error    1051 -                    ^ Access width of Field Unit
>> extends beyond region limit
>>=20
>> dsdt.dsl  1767:                 DCLS,   1,
>> Error    1051 -                    ^ Access width of Field Unit
>> extends beyond region limit
>>=20
>> dsdt.dsl  1768:                 DOPN,   1,
>> Error    1051 -                    ^ Access width of Field Unit
>> extends beyond region limit
>>=20
>> dsdt.dsl  3025:                     Method (SARA, 0, NotSerialized)
>> Warning  2019 -                                ^ Not all control
>> paths=20
>> return a value (SARA)
>>=20
>> dsdt.dsl  3133:                     Method (WSWD, 4, NotSerialized)
>> Warning  2019 -                                ^ Not all control
>> paths=20
>> return a value (WSWD)
>>=20
>> dsdt.dsl  3520:                         /*** Missing
>> EndDependentFunctions descriptor */                    })
>> Error    1071 -                                   Missing
>> EndDependentFn() macro in dependent resource list ^
>>=20
>> dsdt.dsl  3661:                         /*** Missing
>> EndDependentFunctions descriptor */                    })
>> Error    1071 -                                   Missing
>> EndDependentFn() macro in dependent resource list ^
>>=20
>> dsdt.dsl  3732:                         /*** Missing
>> EndDependentFunctions descriptor */                    })
>> Error    1071 -                                   Missing
>> EndDependentFn() macro in dependent resource list ^
>>=20
>> dsdt.dsl  3745:                         /*** Missing
>> EndDependentFunctions descriptor */                    })
>> Error    1071 -                                   Missing
>> EndDependentFn() macro in dependent resource list ^
>>=20
>> dsdt.dsl  4160:                         /*** Missing
>> EndDependentFunctions descriptor */                    })
>> Error    1071 -                                   Missing
>> EndDependentFn() macro in dependent resource list ^
>>=20
>> dsdt.dsl  4229:                     /*** Missing
>> EndDependentFunctions descriptor */                })
>> Error    1071 -                           Missing EndDependentFn()
>> macro in dependent resource list ^
>>=20
>> ASL Input:  dsdt.dsl - 4818 lines, 154622 bytes, 2139 keywords
>> Compilation complete. 11 Errors, 7 Warnings, 0 Remarks, 461
>> Optimizations=20
>>=20
>> Do any of these errors have anything to do with it?
>>=20
>> 2.6.7, 2.6.8.1 and 2.6.9 have all failed to detect the thermal zone
>> on=20
>> this machine; should I investigate a BIOS update?
>>=20
>> The DSDT is available here:
>>=20
>> http://www.pryan.org/mozilla/site/TheOneKEA/misc/dsdt.dsl
>>=20
>> Thanks in advance,
>>=20
>> Brad
>>=20
>> -------------------------------------------------------
>> This SF.net email is sponsored by: IT Product Guide on
>> ITManagersJournal=20
>> Use IT products in your business? Tell us what you think of them.
>> Give us=20
>> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find
>> out more http://productguide.itmanagersjournal.com/guidepromo.tmpl
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on
> ITManagersJournal=20
> Use IT products in your business? Tell us what you think of them.
> Give us Your Opinions, Get Free ThinkGeek Gift Certificates! Click to
> find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________=20
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
