From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 22:16:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212211615.GV13262@poupinou.org>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org> <402B7917.2090505@zopatista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <402B7917.2090505-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 12, 2004 at 08:01:11AM -0500, Martijn Pieters wrote:
> Bruno Ducrot wrote:
> >>dsdt.dsl  2035: Store (Zero, \_PR.CPU0._PPC)
> >>Error    1022 -     Object does not exist ^  (\_PR.CPU0._PPC)
> >
> >
> >Do you have a SSDT table ?  If so, this object may be in that SSDT
> >instead.
> 
> SSDT decompilation fails with:
> 
>  dswload-0264: *** Error: Looking up [\_PR_.CPU0] in namespace, 
> AE_NOT_FOUND
>  psparse-1283: *** Error: [NULL NAME], AE_NOT_FOUND
> Could not parse ACPI tables, AE_NOT_FOUND
> 
> How can I decompile the SSDT table with the DSDT namespace available? Ue 
> an Include in the DSDT AML? Your suspicion could be right,  hexedit of 
> the SSDT code does show a _PPC declaration.

Now we know that there is a _PPC for the processor object, you can
shut off the iasl errors related to that \_PR.CPU0._PPC via
something like that:

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00004010, 0x06) {
            External(_PPC)
        }
    }


Now, the errors are :

dsdt.dsl  2955:                     PWST,   2, 
Error    1051 -                        ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  2957:                     PMEN,   1, 
Error    1051 -                        ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  2959:                     PMST,   1
Error    1051 -                        ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  3237:                 Field (ERAM, AnyAcc, NoLock, Preserve)
Error    1048 -                           ^ Host Operation Region
requires ByteAcc access

that may be fixed.

The 3 first errors are due to this:

                OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
                Field (CCRD, DWordAcc, Lock, Preserve)
                {
                    Offset (0x04),
                    TI04,   8,
                    Offset (0x44),
                    TI44,   16,
                    Offset (0x80),
                    PMEE,   1,
                    Offset (0x81),
                    Offset (0xA4),
                    PWST,   2,
                    Offset (0xA5),
                    PMEN,   1,
                        ,   6,
                    PMST,   1
                }

You have the option to change the length for the OR (that is,
replace the 0xA7 with 0xA8 (that will give you in fact the same
behaviour if you enable the ACPI_RELAX compile kernel option), or
you can change the DWordAcc by WordAcc in the Field.

Unfortunately, that is hard to know what is correct though,
other than to bug the OEM, or to look if those fields can be accessed
as double word in this PCI config space by looking the data book for
this pci device.  It's the only (stable) solution unfortunately, even
though there are some ACPI_PEDANTIC that need to be defined those days
;(


> >>Last but not least, tehre is one Field declaration that wants to define 
> >>AnyAcc to a OperationRegion, something that apparently isn't possible:
> >>
> >>dsdt.dsl  3235: Field (ERAM, AnyAcc, NoLock, Preserve)
> >>Error    1048 -           ^ Host Operation Region requires ByteAcc access
> >
> >> s/AnyAcc/ByteAcc on the faulty line, perhaps ;)
> 
> There are two Field definitions referring to that OperationRegion; one 
> ByteAcc and one AnyAcc. It is clear the author expected this to work and 
> needed the behaviour..
> 

Yes, and?  There is one that is:

                Field (ERAM, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04),
                    CMCM,   8,
                    CMD1,   8,
                    CMD2,   8,
                    CMD3,   8
                }
which is correct.

The second is:
                Field (ERAM, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x80),
                    NMSG,   8,
                    SLED,   4,
                    ...
                    ...

                }
but since ERAM is an EC OR, it need byte access by ACPI specs.
So replace the offending line with:

                Field (ERAM, ByteAcc, NoLock, Preserve)


I don't see where is the trouble doing so, btw.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
