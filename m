From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [Lhms-devel] [PATCH 1/1]  patch to fix
	acpi_memhotplug.c
Date: Thu, 17 Nov 2005 18:22:36 -0800
Message-ID: <1132280556.3798.137.camel@knk>
References: <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>
	 <20051115171221.7E99.Y-GOTO@jp.fujitsu.com> <1132201107.3798.81.camel@knk>
	 <437C1E6C.6000404@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HMf/HQDBSE2jf1j9dDas"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <437C1E6C.6000404-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-HMf/HQDBSE2jf1j9dDas
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-17 at 15:08 +0900, KAMEZAWA Hiroyuki wrote:
> keith wrote:
>  >
>  > My add event is called with my patch.  The notify event is triggering
>  > and falling into the right path.
>  >
>  > I tried your patch but my device is not making and add event.  I really
>  > looks to just be a notify with the memory range attached.  I really
>  > think my patch is the right way to go for my hardware.
>  >
>  >
> Could you show your AML tree around Memory ?

See attached SSDT. 

> I'm interested in.
> 
>   	if (!(*mem_device)) {
> -		printk(KERN_ERR "\n driver data not found");
> -		return_VALUE(-ENODEV);
> +		/* Try and get the memory_device from the current handle */
> +		result = acpi_memory_get_current_resource(handle,mem_device);
> +		if (result) {
> +			printk(KERN_ERR "\nThere is no data for this memory device\n");
> +			return_VALUE(-EINVAL);
> +		}
>   	}
> I'm not sure why this is *right* way.

I am not sure either but the current code just dosen't work for my
event.  
  
> This is traditinal way to attach driver data to device.
> ==
> acpi_bus_add() ->
> 	acpi_add_single_object() ->  ----------------(*) acpi_device is create here.
> 		acpi_bus_find_driver()->
> 			acpi_bus_driver_init()->
> 				driver->ops.add()
The above is not working for my event.  

The current code is 

>>detect if the mem_device is already attached. This call fails for me and I goto end.
       if (!acpi_bus_get_device(handle, &device) && device)
                goto end;

>>If I skip the above by commentting out and just run (isn't the logic backwards anyway?) 

        status = acpi_get_parent(handle, &phandle);
        if (ACPI_FAILURE(status)) {
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_get_parent\n"));
                return_VALUE(-EINVAL);
        }

        /* Get the parent device */
        status = acpi_bus_get_device(phandle, &pdevice);
        if (ACPI_FAILURE(status)) {
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
                                  "Error in acpi_bus_get_device\n"));
                return_VALUE(-EINVAL);
        }

        /*
         * Now add the notified device.  This creates the acpi_device
         * and invokes .add function
         */
        status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
        if (ACPI_FAILURE(status)) {
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
                return_VALUE(-EINVAL);
        }

>> acpi_get_parent acpi_bug_get_device and acpi_bus_add all pass and do
>> not report any failures. But when I check for the mem_device it is 
>> not there.   

	*mem_device = acpi_driver_data(device);
        if (!(*mem_device)) {
                printk(KERN_ERR "\n driver data not found");
                return_VALUE(-ENODEV);
        }

 


>>I sill fall into the error and the call fails 
>>and I see "  driver data not foundacpi_memory-0305 [02]
>>memory_device_notify  : Error in finding driver data""

acpi_bus_add while retuning success is not correctly attaching a formed
memory_device to my generic acpi_device as the api would seem to
indicate.  Perhaps the generic code is broken?


> Maybe driver->ops.add is not called for some reason.
> What happens in () in your environment ?
> acpi_bus_find_driver() is called ?

Well I can tell you I never see the 

printk(KERN_INFO "%s \n", acpi_device_name(device));

from acpi_memory_device_add when I call acpi_bus_add.  I am really
trying not to dig around in the acpi generic code.....  I might have
time to have a look at the generic acpi code tomorrow.... 

Is this driver know to work on any hardware?   

Thanks for your feedback.

-- 
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

--=-HMf/HQDBSE2jf1j9dDas
Content-Disposition: attachment; filename=SSDT.dsl
Content-Type: text/x-dsl; name=SSDT.dsl; charset=utf-8
Content-Transfer-Encoding: 7bit

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20050902
 *
 * Disassembly of SSDT.aml, Thu Nov 17 18:14:58 2005
 */
DefinitionBlock ("SSDT.aml", "SSDT", 1, "IBM   ", "VIGSSDT0", 4096)
{
    /*
     * These objects were referenced but not defined in this table
     */
    External (VP00, DeviceObj)

    Scope (\)
    {
    }

    Scope (\_PR)
    {
        Processor (CP00, 0x00, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP01, 0x01, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP02, 0x02, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP03, 0x03, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP04, 0x04, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP05, 0x05, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP06, 0x06, 0x00000000, 0x00) {}
    }

    Scope (\_PR)
    {
        Processor (CP07, 0x07, 0x00000000, 0x00) {}
    }

    Scope (\)
    {
    }

    Scope (\_SB)
    {
        Device (ME00)
        {
            Name (_HID, EisaId ("PNP0C80"))
            Name (_CID, 0x010CD041)
            Name (_UID, 0x00)
            Name (BADH, 0x00000000)
            Name (BADL, 0x00100000)
            Name (EADH, 0x00000004)
            Name (EADL, 0x80000000)
            Name (MEID, 0x00000001)
            Name (VC00, 0xFDE86000)
            OperationRegion (CY00, SystemMemory, VC00, 0x8000)
            Field (CY00, DWordAcc, NoLock, Preserve)
            {
                Offset (0x150), 
                    ,   26, 
                PMIO,   6, 
                Offset (0x3600), 
                XTP0,   32, 
                XTP1,   32, 
                XTP2,   32, 
                XTP3,   32, 
                XTP4,   32, 
                XTP5,   32, 
                XTP6,   32, 
                XTP7,   32, 
                XTP8,   32, 
                XTP9,   32, 
                XTPA,   32, 
                XTPB,   32, 
                Offset (0x5040), 
                MSZ0,   9, 
                Offset (0x5050), 
                    ,   28, 
                BCRD,   1, 
                CSTE,   1, 
                Offset (0x5098), 
                Offset (0x509C), 
                MMP0,   1, 
                MMP1,   1, 
                MMP2,   1, 
                MMP3,   1, 
                Offset (0x5140), 
                MSZ1,   9, 
                Offset (0x5240), 
                MSZ2,   9, 
                Offset (0x5340), 
                MSZ3,   9
            }

            Name (INIC, 0x00)
            Method (_INI, 0, NotSerialized)
            {
                If (LNot (INIC))
                {
                    Increment (INIC)
                    If (LNot (LEqual (And (XTP0, 0xFF), 0x81)))
                    {
                        And (XTP0, 0xFFFFFFF0, XTP0)
                        And (XTP1, 0xFFFFFFF0, XTP1)
                        And (XTP2, 0xFFFFFFF0, XTP2)
                        And (XTP3, 0xFFFFFFF0, XTP3)
                        And (XTP4, 0xFFFFFFF0, XTP4)
                        And (XTP5, 0xFFFFFFF0, XTP5)
                        And (XTP6, 0xFFFFFFF0, XTP6)
                        And (XTP7, 0xFFFFFFF0, XTP7)
                        And (XTP8, 0xFFFFFFF0, XTP8)
                        And (XTP9, 0xFFFFFFF0, XTP9)
                        And (XTPA, 0xFFFFFFF0, XTPA)
                        And (XTPB, 0xFFFFFFF0, XTPB)
                    }
                }
            }

            Name (ME1S, 0x00)
            Method (_CRS, 0, NotSerialized)
            {
                Store (\_SB.ECRS, BADH)
                BADL
                EADH
                EADL
                PMIO
                Local0
                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)
            {
                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        If (LAnd (LEqual (BADH, EADH), LEqual (BADL, EADL)))
                        {
                            Or (MEID, \_SB.MEMI, \_SB.MEMI)
                            Return (0x00)
                        }
                        Else
                        {
                            And (Not (MEID), \_SB.MEMI, \_SB.MEMI)
                            Return (0x0F)
                        }
                    }
                }

                Return (0x00)
            }

            Method (UPDT, 2, NotSerialized)
            {
                If (\_SB.N2GC)
                {
                    EADH
                    EADL
                    Arg0
                    Arg1
                    Store (Arg0, EADH)
                    Store (Arg1, EADL)
                    Store (0x0F, ME1S)
                    Return (0x01)
                }

                Return (0x00)
            }

            Method (MINT, 0, NotSerialized)
            {
                Store (EADH, Local0)
                Store (EADL, Local1)
                Store (0x00, Local2)
                If (CSTE)
                {
                    If (BCRD)
                    {
                        If (LNot (LAnd (MMP0, MMP2)))
                        {
                            Add (MSZ0, MSZ2, Local2)
                        }
                    }
                    Else
                    {
                        If (LNot (LAnd (MMP1, MMP3)))
                        {
                            Add (MSZ1, MSZ3, Local2)
                        }
                    }

                    If (Local2)
                    {
                        Add (Local0, ShiftRight (Local2, 0x03), Local0)
                        Add (Local1, ShiftLeft (Local2, 0x1D, Local2), Local1)
                        If (LGreater (EADL, Local1))
                        {
                            Increment (Local0)
                        }

                        If (UPDT (Local0, Local1))
                        {
                            ^^ME01.RSET (Local0, Local1)
                            Notify (ME00, 0x01)
                        }
                    }
                }
            }
        }

        Device (ME01)
        {
            Name (_HID, EisaId ("PNP0C80"))
            Name (_CID, 0x010CD041)
            Name (_UID, 0x01)
            Name (BADH, 0x00000004)
            Name (BADL, 0x80000000)
            Name (EADH, 0x00000004)
            Name (EADL, 0x80000000)
            Name (MEID, 0x00000002)
            Name (ME1S, 0x00)
            Method (_CRS, 0, NotSerialized)
            {
                Store (\_SB.ECRS, BADH)
                BADL
                EADH
                EADL
                ^^ME00.PMIO
                Local0
                Return (Local0)
            }

            Method (_STA, 0, NotSerialized)
            {
                If (CondRefOf (_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        If (LAnd (LEqual (BADH, EADH), LEqual (BADL, EADL)))
                        {
                            Or (MEID, \_SB.MEMI, \_SB.MEMI)
                            Return (0x00)
                        }
                        Else
                        {
                            And (Not (MEID), \_SB.MEMI, \_SB.MEMI)
                            Return (0x0F)
                        }
                    }
                }

                Return (0x00)
            }

            Method (RSET, 2, NotSerialized)
            {
                Store (Arg0, BADH)
                Store (Arg1, BADL)
                Store (Arg0, EADH)
                Store (Arg1, EADL)
            }

            Method (UPDT, 2, NotSerialized)
            {
                If (\_SB.N2GC)
                {
                    EADH
                    EADL
                    Arg0
                    Arg1
                    Store (Arg0, EADH)
                    Store (Arg1, EADL)
                    Store (0x0F, ME1S)
                    Return (0x01)
                }

                Return (0x00)
            }

            Method (MINT, 0, NotSerialized)
            {
                Store (EADH, Local0)
                Store (EADL, Local1)
                Store (0x00, Local2)
                If (^^ME00.CSTE)
                {
                    If (^^ME00.BCRD)
                    {
                        If (LNot (LAnd (^^ME00.MMP0, ^^ME00.MMP2)))
                        {
                            Add (^^ME00.MSZ0, ^^ME00.MSZ2, Local2)
                        }
                    }
                    Else
                    {
                        If (LNot (LAnd (^^ME00.MMP1, ^^ME00.MMP3)))
                        {
                            Add (^^ME00.MSZ1, ^^ME00.MSZ3, Local2)
                        }
                    }

                    If (Local2)
                    {
                        Add (Local0, ShiftRight (Local2, 0x03), Local0)
                        Add (Local1, ShiftLeft (Local2, 0x1D, Local2), Local1)
                        If (LGreater (EADL, Local1))
                        {
                            Increment (Local0)
                        }

                        If (UPDT (Local0, Local1))
                        {
                            Notify (ME01, 0x01)
                        }
                    }
                }
            }
        }
    }

    Scope (\_SB)
    {
        Name (VW00, 0xFDA00000)
        Name (VW01, 0xFDB00000)
        Name (VND0, 0x00)
        Name (PAD0, 0xDCFE)
        Scope (VP00)
        {
            Name (XHID, 0x030AD041)
            Name (UIDC, 0xFF)
            Method (XUID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x00, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (XBBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (XADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW00, 0x4000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW00, 0x8000), 0x1000)
            OperationRegion (CALR, SystemMemory, VW00, 0x1000)
            Field (CALR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x778), 
                CNMR,   32
            }

            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW00, 0x8000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    If (VND0)
                    {
                        Or (CNMR, 0x80000000, CNMR)
                    }

                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP01)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x01, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW00, 0x5000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW00, 0x9000), 0x1000)
            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW00, 0x9000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP02)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x02, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW00, 0x6000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW00, 0xA000), 0x1000)
            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW00, 0xA000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP03)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x03, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW00, 0x7000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW00, 0xB000), 0x1000)
            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW00, 0xB000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP04)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x04, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW01, 0x4000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW01, 0x8000), 0x1000)
            OperationRegion (CALR, SystemMemory, VW01, 0x1000)
            Field (CALR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x778), 
                CNMR,   32
            }

            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW01, 0x8000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    If (VND0)
                    {
                        Or (CNMR, 0x80000000, CNMR)
                    }

                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP05)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x05, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW01, 0x5000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW01, 0x9000), 0x1000)
            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW01, 0x9000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP06)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x06, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW01, 0x6000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW01, 0xA000), 0x1000)
            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW01, 0xA000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }

        Device (VP07)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (UIDC, 0xFF)
            Method (_UID, 0, NotSerialized)
            {
                If (LEqual (UIDC, 0xFF))
                {
                    ShiftLeft (VND0, 0x04, UIDC)
                    Add (UIDC, 0x07, UIDC)
                }

                Return (UIDC)
            }

            Name (BBNC, 0xFF)
            Method (_BBN, 0, NotSerialized)
            {
                If (LEqual (BBNC, 0xFF))
                {
                    Store (BBN0, BBNC)
                }

                Return (BBNC)
            }

            Name (_ADR, 0x00)
            OperationRegion (DBGR, SystemMemory, Add (VW01, 0x7000), 0x1000)
            OperationRegion (PHBR, SystemMemory, Add (VW01, 0xB000), 0x1000)
            Field (DBGR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x10), 
                P0DS,   32, 
                Offset (0x20), 
                MLT0,   8, 
                BBN0,   8, 
                SBN0,   8, 
                Offset (0xF8), 
                P0SR,   32, 
                Offset (0x160), 
                P0MR,   32, 
                Offset (0x298), 
                C0MR,   32
            }

            Field (PHBR, DWordAcc, NoLock, Preserve)
            {
                Offset (0x110), 
                C0SR,   32, 
                Offset (0x160), 
                P0CF,   32, 
                Offset (0x170), 
                I0BA,   32, 
                Offset (0x190), 
                M0L1,   32, 
                Offset (0x1A0), 
                M0H1,   32, 
                Offset (0x1B0), 
                I0SZ,   32, 
                Offset (0x1C0), 
                M0S1,   32, 
                Offset (0x2B0), 
                M0L2,   32, 
                Offset (0x2C0), 
                M0H2,   32, 
                Offset (0x2E0), 
                M0S2,   32, 
                Offset (0x880), 
                M0MD,   32
            }

            Name (CRSR, Buffer (SizeOf (CRST)) {})
            Name (PCKG, Package (0x0B)
            {
                0xFF, 
                0xFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (INIC, 0x00)
            Method (_INI, 0, Serialized)
            {
                If (INIC) {}
                Else
                {
                    Increment (INIC)
                    Store (0x00, Local0)
                    Store (BBN0, Index (PCKG, 0x00))
                    Store (SBN0, Index (PCKG, 0x01))
                    Store (I0BA, Index (PCKG, 0x02))
                    Store (I0SZ, Index (PCKG, 0x03))
                    Store (M0L1, Index (PCKG, 0x04))
                    Store (M0S1, Index (PCKG, 0x05))
                    Store (P0CF, Index (PCKG, 0x06))
                    Store (M0L2, Index (PCKG, 0x07))
                    Store (M0S2, Index (PCKG, 0x08))
                    Store (Add (VW01, 0xB000), Index (PCKG, 0x09))
                    Store (Local0, Index (PCKG, 0x0A))
                    Store (ICRS, PCKG)
                    CRSR
                    INIH ()
                    Store (C0MR, ENGC)
                    Store (P0MR, ENGP)
                }
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (CRSR)
            }

            Name (_HPP, Package (0x04)
            {
                0x10, 
                0x64, 
                0x01, 
                0x01
            })
            Name (ENGC, 0x00)
            Name (ENGP, 0x00)
            Name (DBGC, 0x00)
            Name (DBGP, 0x00)
            Name (DBGD, 0x00)
            Method (WRK0, 0, NotSerialized)
            {
            }

            Method (WRK1, 0, NotSerialized)
            {
            }
        }
    }

    Scope (\_SB.VP00)
    {
        Name (API0, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000010
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x00, 
                0x00, 
                0x00000014
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x01, 
                0x00, 
                0x00000014
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                0x00, 
                0x00000014
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x60, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP01)
    {
        Name (API1, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000018
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x0000001C
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x00, 
                0x00, 
                0x00000019
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x01, 
                0x00, 
                0x0000001D
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x61, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP02)
    {
        Name (API2, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000012
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x00000016
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                0x00, 
                0x0000001A
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                0x00, 
                0x0000001E
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x62, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP03)
    {
        Name (API3, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000013
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x00000017
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                0x00, 
                0x0000001B
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                0x00, 
                0x0000001F
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x62, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP04)
    {
        Name (API4, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000033
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x00000037
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                0x00, 
                0x0000003B
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                0x00, 
                0x0000003F
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x62, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP05)
    {
        Name (API5, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000034
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x00000038
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                0x00, 
                0x0000003C
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                0x00, 
                0x00000040
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x62, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP06)
    {
        Name (API6, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000035
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x00000039
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                0x00, 
                0x0000003D
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                0x00, 
                0x00000041
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x62, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP07)
    {
        Name (API7, 0x00)
        Name (PICM, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (APIC, Package (0x04)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                0x00, 
                0x00, 
                0x00000036
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x01, 
                0x00, 
                0x0000003A
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                0x00, 
                0x0000003E
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                0x00, 
                0x00000042
            }
        })
        Method (_PRT, 0, NotSerialized)
        {
            Store (0x62, IOPT)
            If (LNot (PICF))
            {
                Return (PICM)
            }
            Else
            {
                Return (APIC)
            }
        }
    }

    Scope (\_SB.VP00)
    {
        Method (SUNC, 1, NotSerialized)
        {
            Multiply (VND0, 0x06, Local0)
            Add (Local0, Arg0, Local0)
            Return (Local0)
        }

        Method (ROWB, 1, NotSerialized)
        {
            Multiply (VND0, 0x08, Local0)
            Add (Arg0, 0x02, Local0)
            Return (Local0)
        }

        Method (ROWS, 1, NotSerialized)
        {
            Add (SUNC (Arg0), 0x40, Local0)
            Return (Local0)
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.ROWB (0x01), Local1)
            Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Local1)), 0x00))
            Store (^_BBN, Index (DerefOf (Index (\_SB.APCI.APCI, Local1)), 0x05))
            Store (\_SB.VP00.ROWS (0x01), Local2)
            Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Local2)), 0x00))
            Add (VND0, 0x71, Local3)
            Store (0x86, Index (DerefOf (Index (\_SB.APCI.APCI, Local3)), 0x00))
        }
    }

    Scope (\_SB.VP01)
    {
        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.ROWB (0x02), Local1)
            Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Local1)), 0x00))
            Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Local1)), 0x05))
            Store (\_SB.VP00.ROWS (0x02), Local2)
            Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Local2)), 0x00))
        }
    }

    Scope (\_SB.VP02)
    {
        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB00), 
            SHBZ,   16, 
            Offset (0xB2F), 
            SHBD,   3, 
            Offset (0xB31), 
            SHBF,   1, 
            SHBG,   3, 
            Offset (0xB32), 
            SHBY,   5, 
            Offset (0xB33), 
            SHBE,   8, 
            Offset (0xB37), 
            SHBH,   8, 
            Offset (0xB3F), 
            SHBS,   8, 
            SHBT,   8, 
            SHBN,   1, 
            SHBO,   1, 
            SHBP,   1, 
            SHBQ,   1, 
            SHBR,   1, 
            Offset (0xB42), 
            SHBJ,   1, 
            SHBK,   1, 
            SHBL,   2, 
            SHBM,   2, 
            Offset (0xB43), 
            SHBI,   2
        }

        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB2C), 
            SHRD,   3, 
            Offset (0xB30), 
            SHRE,   8, 
            SHRY,   5, 
            Offset (0xB32), 
            SHRF,   1, 
            SHRG,   3, 
            Offset (0xB34), 
            SHRH,   32, 
            Offset (0xB3C), 
            SHRS,   8, 
            Offset (0xB40), 
            SHRI,   2, 
            Offset (0xB41), 
            SHRJ,   1, 
            SHRK,   1, 
            SHRL,   2, 
            SHRM,   2, 
            Offset (0xB42), 
            SHRN,   1, 
            SHRO,   1, 
            SHRP,   1, 
            SHRQ,   1, 
            SHRR,   1, 
            Offset (0xB43), 
            SHRT,   8
        }

        Method (SHPC, 1, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                Store (Local1, ^SHRY)
                Store (Arg0, ^SHRE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                If (^SHRG)
                {
                    BreakPoint
                }
            }
            Else
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                If (LEqual (Local1, 0x00))
                {
                    Increment (Local1)
                }

                Store (Local1, ^SHBY)
                Store (Arg0, ^SHBE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                If (^SHBG)
                {
                    BreakPoint
                }
            }
        }

        Method (SHPF, 0, Serialized)
        {
            ^WRK0 ()
            ^SHPC (Or (Or (0x0100, 0x03), Or (0x10, 0x0C)))
            \_SB.APCI.ZZZN
            ^S1F0.SHPX
            0xE0
            Store (0x03, ^S1F0.SHPP)
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRL, ^S1F0.SHPQ)
            }
            Else
            {
                Store (^SHBL, ^S1F0.SHPQ)
            }
        }

        Method (SHPE, 0, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRH, Local0)
                While (Store (^SHRH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHRN)
                        {
                            Store (One, ^SHRN)
                            Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPX)), 0x0A))
                        }

                        If (^SHRO)
                        {
                            Store (One, ^SHRO)
                            BreakPoint
                        }

                        If (^SHRP)
                        {
                            Store (One, ^SHRP)
                        }

                        If (^SHRQ)
                        {
                            Store (One, ^SHRQ)
                            If (LNot (LEqual (^SHRI, 0x03)))
                            {
                                BreakPoint
                            }

                            ^WRK0 ()
                            If (LEqual (^S1F0.SHPP, 0x02))
                            {
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S1F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHRJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHRL, 0x03))
                                    {
                                        If (LNot (LEqual (^S1F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S1F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHRM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHRM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHRK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHRO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHRO)
                                            \_SB.APCI.ZZZN
                                            ^S1F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S1F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHRD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHRI, ^S1F0.SHPP)
                            Store (^SHRL, ^S1F0.SHPQ)
                        }

                        If (^SHRR)
                        {
                            Store (One, ^SHRR)
                            ^WRK0 ()
                            Store (One, ^SHRR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHRR)
                            \_SB.APCI.ZZZN
                            ^S1F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
            Else
            {
                Store (^SHBH, Local0)
                While (Store (^SHBH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHBN)
                        {
                            Store (One, ^SHBN)
                            Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPX)), 0x0A))
                        }

                        If (^SHBO)
                        {
                            Store (One, ^SHBO)
                            BreakPoint
                        }

                        If (^SHBP)
                        {
                            Store (One, ^SHBP)
                        }

                        If (^SHBQ)
                        {
                            Store (One, ^SHBQ)
                            If (LNot (LEqual (^SHBI, 0x03)))
                            {
                                BreakPoint
                            }

                            If (LEqual (^S1F0.SHPP, 0x02))
                            {
                                ^WRK0 ()
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S1F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHBJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHBL, 0x03))
                                    {
                                        If (LNot (LEqual (^S1F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S1F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHBM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHBM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHBK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHBO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHBO)
                                            \_SB.APCI.ZZZN
                                            ^S1F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S1F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHBD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHBI, ^S1F0.SHPP)
                            Store (^SHBL, ^S1F0.SHPQ)
                        }

                        If (^SHBR)
                        {
                            ^WRK0 ()
                            Store (One, ^SHBR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHBR)
                            \_SB.APCI.ZZZN
                            ^S1F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
        }

        Name (SHPB, Buffer (0x08)
        {
            0x00, 0x01, 0x05, 0x06, 0x07, 0xFF, 0xFF, 0xFF
        })
        Method (SHPI, 4, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHRS)
                    Store (0x65, ^SHRT)
                    If (LNot (LEqual (^SHRI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S1F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S1F0.SHPX)
                    Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S1F0.SHPS)
                    Store (Arg1, ^S1F0._SUN)
                    Store (^SHRI, ^S1F0.SHPP)
                    Store (^SHRL, ^S1F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S1F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S1F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHBS)
                    Store (0x65, ^SHBT)
                    If (LNot (LEqual (^SHBI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S1F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S1F0.SHPX)
                    Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S1F0.SHPS)
                    Store (Arg1, ^S1F0._SUN)
                    Store (^SHBI, ^S1F0.SHPP)
                    Store (^SHBL, ^S1F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S1F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S1F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S1F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
        }

        Device (S1F0)
        {
            Name (_ADR, 0x00010000)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Name (_SUN, Ones)
            Name (SHPP, Ones)
            Name (SHPQ, Ones)
            Name (SHPS, Ones)
            Name (SHPX, Ones)
            Name (SHPY, Ones)
        }

        Device (S1F1)
        {
            Name (_ADR, 0x00010001)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Device (S1F2)
        {
            Name (_ADR, 0x00010002)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Device (S1F3)
        {
            Name (_ADR, 0x00010003)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Device (S1F4)
        {
            Name (_ADR, 0x00010004)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Device (S1F5)
        {
            Name (_ADR, 0x00010005)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Device (S1F6)
        {
            Name (_ADR, 0x00010006)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Device (S1F7)
        {
            Name (_ADR, 0x00010007)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S1F0._SUN)
            }
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.SUNC (0x01), Local0)
            Store (\_SB.VP00.ROWB (0x01), Local1)
            Store (\_SB.VP00.ROWS (0x01), Local2)
            SHPI (Zero, Local0, Local1, Local2)
        }
    }

    Scope (\_SB.VP03)
    {
        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB00), 
            SHBZ,   16, 
            Offset (0xB2F), 
            SHBD,   3, 
            Offset (0xB31), 
            SHBF,   1, 
            SHBG,   3, 
            Offset (0xB32), 
            SHBY,   5, 
            Offset (0xB33), 
            SHBE,   8, 
            Offset (0xB37), 
            SHBH,   8, 
            Offset (0xB3F), 
            SHBS,   8, 
            SHBT,   8, 
            SHBN,   1, 
            SHBO,   1, 
            SHBP,   1, 
            SHBQ,   1, 
            SHBR,   1, 
            Offset (0xB42), 
            SHBJ,   1, 
            SHBK,   1, 
            SHBL,   2, 
            SHBM,   2, 
            Offset (0xB43), 
            SHBI,   2
        }

        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB2C), 
            SHRD,   3, 
            Offset (0xB30), 
            SHRE,   8, 
            SHRY,   5, 
            Offset (0xB32), 
            SHRF,   1, 
            SHRG,   3, 
            Offset (0xB34), 
            SHRH,   32, 
            Offset (0xB3C), 
            SHRS,   8, 
            Offset (0xB40), 
            SHRI,   2, 
            Offset (0xB41), 
            SHRJ,   1, 
            SHRK,   1, 
            SHRL,   2, 
            SHRM,   2, 
            Offset (0xB42), 
            SHRN,   1, 
            SHRO,   1, 
            SHRP,   1, 
            SHRQ,   1, 
            SHRR,   1, 
            Offset (0xB43), 
            SHRT,   8
        }

        Method (SHPC, 1, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                Store (Local1, ^SHRY)
                Store (Arg0, ^SHRE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                If (^SHRG)
                {
                    BreakPoint
                }
            }
            Else
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                If (LEqual (Local1, 0x00))
                {
                    Increment (Local1)
                }

                Store (Local1, ^SHBY)
                Store (Arg0, ^SHBE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                If (^SHBG)
                {
                    BreakPoint
                }
            }
        }

        Method (SHPF, 0, Serialized)
        {
            ^WRK0 ()
            ^SHPC (Or (Or (0x0100, 0x03), Or (0x10, 0x0C)))
            \_SB.APCI.ZZZN
            ^S2F0.SHPX
            0xE0
            Store (0x03, ^S2F0.SHPP)
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRL, ^S2F0.SHPQ)
            }
            Else
            {
                Store (^SHBL, ^S2F0.SHPQ)
            }
        }

        Method (SHPE, 0, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRH, Local0)
                While (Store (^SHRH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHRN)
                        {
                            Store (One, ^SHRN)
                            Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPX)), 0x0A))
                        }

                        If (^SHRO)
                        {
                            Store (One, ^SHRO)
                            BreakPoint
                        }

                        If (^SHRP)
                        {
                            Store (One, ^SHRP)
                        }

                        If (^SHRQ)
                        {
                            Store (One, ^SHRQ)
                            If (LNot (LEqual (^SHRI, 0x03)))
                            {
                                BreakPoint
                            }

                            ^WRK0 ()
                            If (LEqual (^S2F0.SHPP, 0x02))
                            {
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S2F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHRJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHRL, 0x03))
                                    {
                                        If (LNot (LEqual (^S2F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S2F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHRM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHRM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHRK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHRO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHRO)
                                            \_SB.APCI.ZZZN
                                            ^S2F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S2F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHRD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHRI, ^S2F0.SHPP)
                            Store (^SHRL, ^S2F0.SHPQ)
                        }

                        If (^SHRR)
                        {
                            Store (One, ^SHRR)
                            ^WRK0 ()
                            Store (One, ^SHRR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHRR)
                            \_SB.APCI.ZZZN
                            ^S2F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
            Else
            {
                Store (^SHBH, Local0)
                While (Store (^SHBH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHBN)
                        {
                            Store (One, ^SHBN)
                            Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPX)), 0x0A))
                        }

                        If (^SHBO)
                        {
                            Store (One, ^SHBO)
                            BreakPoint
                        }

                        If (^SHBP)
                        {
                            Store (One, ^SHBP)
                        }

                        If (^SHBQ)
                        {
                            Store (One, ^SHBQ)
                            If (LNot (LEqual (^SHBI, 0x03)))
                            {
                                BreakPoint
                            }

                            If (LEqual (^S2F0.SHPP, 0x02))
                            {
                                ^WRK0 ()
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S2F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHBJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHBL, 0x03))
                                    {
                                        If (LNot (LEqual (^S2F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S2F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHBM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHBM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHBK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHBO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHBO)
                                            \_SB.APCI.ZZZN
                                            ^S2F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S2F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHBD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHBI, ^S2F0.SHPP)
                            Store (^SHBL, ^S2F0.SHPQ)
                        }

                        If (^SHBR)
                        {
                            ^WRK0 ()
                            Store (One, ^SHBR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHBR)
                            \_SB.APCI.ZZZN
                            ^S2F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
        }

        Name (SHPB, Buffer (0x08)
        {
            0x00, 0x01, 0x05, 0x06, 0x07, 0xFF, 0xFF, 0xFF
        })
        Method (SHPI, 4, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHRS)
                    Store (0x65, ^SHRT)
                    If (LNot (LEqual (^SHRI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S2F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S2F0.SHPX)
                    Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S2F0.SHPS)
                    Store (Arg1, ^S2F0._SUN)
                    Store (^SHRI, ^S2F0.SHPP)
                    Store (^SHRL, ^S2F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S2F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S2F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHBS)
                    Store (0x65, ^SHBT)
                    If (LNot (LEqual (^SHBI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S2F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S2F0.SHPX)
                    Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S2F0.SHPS)
                    Store (Arg1, ^S2F0._SUN)
                    Store (^SHBI, ^S2F0.SHPP)
                    Store (^SHBL, ^S2F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S2F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S2F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S2F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
        }

        Device (S2F0)
        {
            Name (_ADR, 0x00010000)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Name (_SUN, Ones)
            Name (SHPP, Ones)
            Name (SHPQ, Ones)
            Name (SHPS, Ones)
            Name (SHPX, Ones)
            Name (SHPY, Ones)
        }

        Device (S2F1)
        {
            Name (_ADR, 0x00010001)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Device (S2F2)
        {
            Name (_ADR, 0x00010002)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Device (S2F3)
        {
            Name (_ADR, 0x00010003)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Device (S2F4)
        {
            Name (_ADR, 0x00010004)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Device (S2F5)
        {
            Name (_ADR, 0x00010005)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Device (S2F6)
        {
            Name (_ADR, 0x00010006)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Device (S2F7)
        {
            Name (_ADR, 0x00010007)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S2F0._SUN)
            }
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.SUNC (0x02), Local0)
            Store (\_SB.VP00.ROWB (0x02), Local1)
            Store (\_SB.VP00.ROWS (0x02), Local2)
            SHPI (Zero, Local0, Local1, Local2)
        }
    }

    Scope (\_SB.VP04)
    {
        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB00), 
            SHBZ,   16, 
            Offset (0xB2F), 
            SHBD,   3, 
            Offset (0xB31), 
            SHBF,   1, 
            SHBG,   3, 
            Offset (0xB32), 
            SHBY,   5, 
            Offset (0xB33), 
            SHBE,   8, 
            Offset (0xB37), 
            SHBH,   8, 
            Offset (0xB3F), 
            SHBS,   8, 
            SHBT,   8, 
            SHBN,   1, 
            SHBO,   1, 
            SHBP,   1, 
            SHBQ,   1, 
            SHBR,   1, 
            Offset (0xB42), 
            SHBJ,   1, 
            SHBK,   1, 
            SHBL,   2, 
            SHBM,   2, 
            Offset (0xB43), 
            SHBI,   2
        }

        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB2C), 
            SHRD,   3, 
            Offset (0xB30), 
            SHRE,   8, 
            SHRY,   5, 
            Offset (0xB32), 
            SHRF,   1, 
            SHRG,   3, 
            Offset (0xB34), 
            SHRH,   32, 
            Offset (0xB3C), 
            SHRS,   8, 
            Offset (0xB40), 
            SHRI,   2, 
            Offset (0xB41), 
            SHRJ,   1, 
            SHRK,   1, 
            SHRL,   2, 
            SHRM,   2, 
            Offset (0xB42), 
            SHRN,   1, 
            SHRO,   1, 
            SHRP,   1, 
            SHRQ,   1, 
            SHRR,   1, 
            Offset (0xB43), 
            SHRT,   8
        }

        Method (SHPC, 1, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                Store (Local1, ^SHRY)
                Store (Arg0, ^SHRE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                If (^SHRG)
                {
                    BreakPoint
                }
            }
            Else
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                If (LEqual (Local1, 0x00))
                {
                    Increment (Local1)
                }

                Store (Local1, ^SHBY)
                Store (Arg0, ^SHBE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                If (^SHBG)
                {
                    BreakPoint
                }
            }
        }

        Method (SHPF, 0, Serialized)
        {
            ^WRK0 ()
            ^SHPC (Or (Or (0x0100, 0x03), Or (0x10, 0x0C)))
            \_SB.APCI.ZZZN
            ^S3F0.SHPX
            0xE0
            Store (0x03, ^S3F0.SHPP)
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRL, ^S3F0.SHPQ)
            }
            Else
            {
                Store (^SHBL, ^S3F0.SHPQ)
            }
        }

        Method (SHPE, 0, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRH, Local0)
                While (Store (^SHRH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHRN)
                        {
                            Store (One, ^SHRN)
                            Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPX)), 0x0A))
                        }

                        If (^SHRO)
                        {
                            Store (One, ^SHRO)
                            BreakPoint
                        }

                        If (^SHRP)
                        {
                            Store (One, ^SHRP)
                        }

                        If (^SHRQ)
                        {
                            Store (One, ^SHRQ)
                            If (LNot (LEqual (^SHRI, 0x03)))
                            {
                                BreakPoint
                            }

                            ^WRK0 ()
                            If (LEqual (^S3F0.SHPP, 0x02))
                            {
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S3F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHRJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHRL, 0x03))
                                    {
                                        If (LNot (LEqual (^S3F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S3F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHRM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHRM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHRK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHRO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHRO)
                                            \_SB.APCI.ZZZN
                                            ^S3F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S3F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHRD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHRI, ^S3F0.SHPP)
                            Store (^SHRL, ^S3F0.SHPQ)
                        }

                        If (^SHRR)
                        {
                            Store (One, ^SHRR)
                            ^WRK0 ()
                            Store (One, ^SHRR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHRR)
                            \_SB.APCI.ZZZN
                            ^S3F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
            Else
            {
                Store (^SHBH, Local0)
                While (Store (^SHBH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHBN)
                        {
                            Store (One, ^SHBN)
                            Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPX)), 0x0A))
                        }

                        If (^SHBO)
                        {
                            Store (One, ^SHBO)
                            BreakPoint
                        }

                        If (^SHBP)
                        {
                            Store (One, ^SHBP)
                        }

                        If (^SHBQ)
                        {
                            Store (One, ^SHBQ)
                            If (LNot (LEqual (^SHBI, 0x03)))
                            {
                                BreakPoint
                            }

                            If (LEqual (^S3F0.SHPP, 0x02))
                            {
                                ^WRK0 ()
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S3F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHBJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHBL, 0x03))
                                    {
                                        If (LNot (LEqual (^S3F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S3F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHBM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHBM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHBK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHBO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHBO)
                                            \_SB.APCI.ZZZN
                                            ^S3F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S3F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHBD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHBI, ^S3F0.SHPP)
                            Store (^SHBL, ^S3F0.SHPQ)
                        }

                        If (^SHBR)
                        {
                            ^WRK0 ()
                            Store (One, ^SHBR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHBR)
                            \_SB.APCI.ZZZN
                            ^S3F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
        }

        Name (SHPB, Buffer (0x08)
        {
            0x00, 0x01, 0x05, 0x06, 0x07, 0xFF, 0xFF, 0xFF
        })
        Method (SHPI, 4, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHRS)
                    Store (0x65, ^SHRT)
                    If (LNot (LEqual (^SHRI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S3F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S3F0.SHPX)
                    Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S3F0.SHPS)
                    Store (Arg1, ^S3F0._SUN)
                    Store (^SHRI, ^S3F0.SHPP)
                    Store (^SHRL, ^S3F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S3F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S3F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHBS)
                    Store (0x65, ^SHBT)
                    If (LNot (LEqual (^SHBI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S3F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S3F0.SHPX)
                    Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S3F0.SHPS)
                    Store (Arg1, ^S3F0._SUN)
                    Store (^SHBI, ^S3F0.SHPP)
                    Store (^SHBL, ^S3F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S3F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S3F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S3F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
        }

        Device (S3F0)
        {
            Name (_ADR, 0x00010000)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Name (_SUN, Ones)
            Name (SHPP, Ones)
            Name (SHPQ, Ones)
            Name (SHPS, Ones)
            Name (SHPX, Ones)
            Name (SHPY, Ones)
        }

        Device (S3F1)
        {
            Name (_ADR, 0x00010001)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Device (S3F2)
        {
            Name (_ADR, 0x00010002)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Device (S3F3)
        {
            Name (_ADR, 0x00010003)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Device (S3F4)
        {
            Name (_ADR, 0x00010004)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Device (S3F5)
        {
            Name (_ADR, 0x00010005)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Device (S3F6)
        {
            Name (_ADR, 0x00010006)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Device (S3F7)
        {
            Name (_ADR, 0x00010007)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S3F0._SUN)
            }
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.SUNC (0x03), Local0)
            Store (\_SB.VP00.ROWB (0x03), Local1)
            Store (\_SB.VP00.ROWS (0x03), Local2)
            SHPI (Zero, Local0, Local1, Local2)
        }
    }

    Scope (\_SB.VP05)
    {
        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB00), 
            SHBZ,   16, 
            Offset (0xB2F), 
            SHBD,   3, 
            Offset (0xB31), 
            SHBF,   1, 
            SHBG,   3, 
            Offset (0xB32), 
            SHBY,   5, 
            Offset (0xB33), 
            SHBE,   8, 
            Offset (0xB37), 
            SHBH,   8, 
            Offset (0xB3F), 
            SHBS,   8, 
            SHBT,   8, 
            SHBN,   1, 
            SHBO,   1, 
            SHBP,   1, 
            SHBQ,   1, 
            SHBR,   1, 
            Offset (0xB42), 
            SHBJ,   1, 
            SHBK,   1, 
            SHBL,   2, 
            SHBM,   2, 
            Offset (0xB43), 
            SHBI,   2
        }

        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB2C), 
            SHRD,   3, 
            Offset (0xB30), 
            SHRE,   8, 
            SHRY,   5, 
            Offset (0xB32), 
            SHRF,   1, 
            SHRG,   3, 
            Offset (0xB34), 
            SHRH,   32, 
            Offset (0xB3C), 
            SHRS,   8, 
            Offset (0xB40), 
            SHRI,   2, 
            Offset (0xB41), 
            SHRJ,   1, 
            SHRK,   1, 
            SHRL,   2, 
            SHRM,   2, 
            Offset (0xB42), 
            SHRN,   1, 
            SHRO,   1, 
            SHRP,   1, 
            SHRQ,   1, 
            SHRR,   1, 
            Offset (0xB43), 
            SHRT,   8
        }

        Method (SHPC, 1, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                Store (Local1, ^SHRY)
                Store (Arg0, ^SHRE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                If (^SHRG)
                {
                    BreakPoint
                }
            }
            Else
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                If (LEqual (Local1, 0x00))
                {
                    Increment (Local1)
                }

                Store (Local1, ^SHBY)
                Store (Arg0, ^SHBE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                If (^SHBG)
                {
                    BreakPoint
                }
            }
        }

        Method (SHPF, 0, Serialized)
        {
            ^WRK0 ()
            ^SHPC (Or (Or (0x0100, 0x03), Or (0x10, 0x0C)))
            \_SB.APCI.ZZZN
            ^S4F0.SHPX
            0xE0
            Store (0x03, ^S4F0.SHPP)
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRL, ^S4F0.SHPQ)
            }
            Else
            {
                Store (^SHBL, ^S4F0.SHPQ)
            }
        }

        Method (SHPE, 0, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRH, Local0)
                While (Store (^SHRH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHRN)
                        {
                            Store (One, ^SHRN)
                            Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPX)), 0x0A))
                        }

                        If (^SHRO)
                        {
                            Store (One, ^SHRO)
                            BreakPoint
                        }

                        If (^SHRP)
                        {
                            Store (One, ^SHRP)
                        }

                        If (^SHRQ)
                        {
                            Store (One, ^SHRQ)
                            If (LNot (LEqual (^SHRI, 0x03)))
                            {
                                BreakPoint
                            }

                            ^WRK0 ()
                            If (LEqual (^S4F0.SHPP, 0x02))
                            {
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S4F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHRJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHRL, 0x03))
                                    {
                                        If (LNot (LEqual (^S4F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S4F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHRM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHRM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHRK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHRO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHRO)
                                            \_SB.APCI.ZZZN
                                            ^S4F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S4F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHRD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHRI, ^S4F0.SHPP)
                            Store (^SHRL, ^S4F0.SHPQ)
                        }

                        If (^SHRR)
                        {
                            Store (One, ^SHRR)
                            ^WRK0 ()
                            Store (One, ^SHRR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHRR)
                            \_SB.APCI.ZZZN
                            ^S4F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
            Else
            {
                Store (^SHBH, Local0)
                While (Store (^SHBH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHBN)
                        {
                            Store (One, ^SHBN)
                            Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPX)), 0x0A))
                        }

                        If (^SHBO)
                        {
                            Store (One, ^SHBO)
                            BreakPoint
                        }

                        If (^SHBP)
                        {
                            Store (One, ^SHBP)
                        }

                        If (^SHBQ)
                        {
                            Store (One, ^SHBQ)
                            If (LNot (LEqual (^SHBI, 0x03)))
                            {
                                BreakPoint
                            }

                            If (LEqual (^S4F0.SHPP, 0x02))
                            {
                                ^WRK0 ()
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S4F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHBJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHBL, 0x03))
                                    {
                                        If (LNot (LEqual (^S4F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S4F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHBM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHBM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHBK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHBO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHBO)
                                            \_SB.APCI.ZZZN
                                            ^S4F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S4F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHBD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHBI, ^S4F0.SHPP)
                            Store (^SHBL, ^S4F0.SHPQ)
                        }

                        If (^SHBR)
                        {
                            ^WRK0 ()
                            Store (One, ^SHBR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHBR)
                            \_SB.APCI.ZZZN
                            ^S4F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
        }

        Name (SHPB, Buffer (0x08)
        {
            0x00, 0x01, 0x05, 0x06, 0x07, 0xFF, 0xFF, 0xFF
        })
        Method (SHPI, 4, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHRS)
                    Store (0x65, ^SHRT)
                    If (LNot (LEqual (^SHRI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S4F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S4F0.SHPX)
                    Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S4F0.SHPS)
                    Store (Arg1, ^S4F0._SUN)
                    Store (^SHRI, ^S4F0.SHPP)
                    Store (^SHRL, ^S4F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S4F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S4F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHBS)
                    Store (0x65, ^SHBT)
                    If (LNot (LEqual (^SHBI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S4F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S4F0.SHPX)
                    Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S4F0.SHPS)
                    Store (Arg1, ^S4F0._SUN)
                    Store (^SHBI, ^S4F0.SHPP)
                    Store (^SHBL, ^S4F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S4F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S4F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S4F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
        }

        Device (S4F0)
        {
            Name (_ADR, 0x00010000)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Name (_SUN, Ones)
            Name (SHPP, Ones)
            Name (SHPQ, Ones)
            Name (SHPS, Ones)
            Name (SHPX, Ones)
            Name (SHPY, Ones)
        }

        Device (S4F1)
        {
            Name (_ADR, 0x00010001)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Device (S4F2)
        {
            Name (_ADR, 0x00010002)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Device (S4F3)
        {
            Name (_ADR, 0x00010003)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Device (S4F4)
        {
            Name (_ADR, 0x00010004)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Device (S4F5)
        {
            Name (_ADR, 0x00010005)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Device (S4F6)
        {
            Name (_ADR, 0x00010006)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Device (S4F7)
        {
            Name (_ADR, 0x00010007)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S4F0._SUN)
            }
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.SUNC (0x04), Local0)
            Store (\_SB.VP00.ROWB (0x04), Local1)
            Store (\_SB.VP00.ROWS (0x04), Local2)
            SHPI (Zero, Local0, Local1, Local2)
        }
    }

    Scope (\_SB.VP06)
    {
        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB00), 
            SHBZ,   16, 
            Offset (0xB2F), 
            SHBD,   3, 
            Offset (0xB31), 
            SHBF,   1, 
            SHBG,   3, 
            Offset (0xB32), 
            SHBY,   5, 
            Offset (0xB33), 
            SHBE,   8, 
            Offset (0xB37), 
            SHBH,   8, 
            Offset (0xB3F), 
            SHBS,   8, 
            SHBT,   8, 
            SHBN,   1, 
            SHBO,   1, 
            SHBP,   1, 
            SHBQ,   1, 
            SHBR,   1, 
            Offset (0xB42), 
            SHBJ,   1, 
            SHBK,   1, 
            SHBL,   2, 
            SHBM,   2, 
            Offset (0xB43), 
            SHBI,   2
        }

        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB2C), 
            SHRD,   3, 
            Offset (0xB30), 
            SHRE,   8, 
            SHRY,   5, 
            Offset (0xB32), 
            SHRF,   1, 
            SHRG,   3, 
            Offset (0xB34), 
            SHRH,   32, 
            Offset (0xB3C), 
            SHRS,   8, 
            Offset (0xB40), 
            SHRI,   2, 
            Offset (0xB41), 
            SHRJ,   1, 
            SHRK,   1, 
            SHRL,   2, 
            SHRM,   2, 
            Offset (0xB42), 
            SHRN,   1, 
            SHRO,   1, 
            SHRP,   1, 
            SHRQ,   1, 
            SHRR,   1, 
            Offset (0xB43), 
            SHRT,   8
        }

        Method (SHPC, 1, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                Store (Local1, ^SHRY)
                Store (Arg0, ^SHRE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                If (^SHRG)
                {
                    BreakPoint
                }
            }
            Else
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                If (LEqual (Local1, 0x00))
                {
                    Increment (Local1)
                }

                Store (Local1, ^SHBY)
                Store (Arg0, ^SHBE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                If (^SHBG)
                {
                    BreakPoint
                }
            }
        }

        Method (SHPF, 0, Serialized)
        {
            ^WRK0 ()
            ^SHPC (Or (Or (0x0100, 0x03), Or (0x10, 0x0C)))
            \_SB.APCI.ZZZN
            ^S5F0.SHPX
            0xE0
            Store (0x03, ^S5F0.SHPP)
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRL, ^S5F0.SHPQ)
            }
            Else
            {
                Store (^SHBL, ^S5F0.SHPQ)
            }
        }

        Method (SHPE, 0, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRH, Local0)
                While (Store (^SHRH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHRN)
                        {
                            Store (One, ^SHRN)
                            Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPX)), 0x0A))
                        }

                        If (^SHRO)
                        {
                            Store (One, ^SHRO)
                            BreakPoint
                        }

                        If (^SHRP)
                        {
                            Store (One, ^SHRP)
                        }

                        If (^SHRQ)
                        {
                            Store (One, ^SHRQ)
                            If (LNot (LEqual (^SHRI, 0x03)))
                            {
                                BreakPoint
                            }

                            ^WRK0 ()
                            If (LEqual (^S5F0.SHPP, 0x02))
                            {
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S5F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHRJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHRL, 0x03))
                                    {
                                        If (LNot (LEqual (^S5F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S5F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHRM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHRM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHRK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHRO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHRO)
                                            \_SB.APCI.ZZZN
                                            ^S5F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S5F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHRD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHRI, ^S5F0.SHPP)
                            Store (^SHRL, ^S5F0.SHPQ)
                        }

                        If (^SHRR)
                        {
                            Store (One, ^SHRR)
                            ^WRK0 ()
                            Store (One, ^SHRR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHRR)
                            \_SB.APCI.ZZZN
                            ^S5F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
            Else
            {
                Store (^SHBH, Local0)
                While (Store (^SHBH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHBN)
                        {
                            Store (One, ^SHBN)
                            Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPX)), 0x0A))
                        }

                        If (^SHBO)
                        {
                            Store (One, ^SHBO)
                            BreakPoint
                        }

                        If (^SHBP)
                        {
                            Store (One, ^SHBP)
                        }

                        If (^SHBQ)
                        {
                            Store (One, ^SHBQ)
                            If (LNot (LEqual (^SHBI, 0x03)))
                            {
                                BreakPoint
                            }

                            If (LEqual (^S5F0.SHPP, 0x02))
                            {
                                ^WRK0 ()
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S5F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHBJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHBL, 0x03))
                                    {
                                        If (LNot (LEqual (^S5F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S5F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHBM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHBM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHBK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHBO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHBO)
                                            \_SB.APCI.ZZZN
                                            ^S5F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S5F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHBD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHBI, ^S5F0.SHPP)
                            Store (^SHBL, ^S5F0.SHPQ)
                        }

                        If (^SHBR)
                        {
                            ^WRK0 ()
                            Store (One, ^SHBR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHBR)
                            \_SB.APCI.ZZZN
                            ^S5F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
        }

        Name (SHPB, Buffer (0x08)
        {
            0x00, 0x01, 0x05, 0x06, 0x07, 0xFF, 0xFF, 0xFF
        })
        Method (SHPI, 4, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHRS)
                    Store (0x65, ^SHRT)
                    If (LNot (LEqual (^SHRI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S5F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S5F0.SHPX)
                    Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S5F0.SHPS)
                    Store (Arg1, ^S5F0._SUN)
                    Store (^SHRI, ^S5F0.SHPP)
                    Store (^SHRL, ^S5F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S5F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S5F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHBS)
                    Store (0x65, ^SHBT)
                    If (LNot (LEqual (^SHBI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S5F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S5F0.SHPX)
                    Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S5F0.SHPS)
                    Store (Arg1, ^S5F0._SUN)
                    Store (^SHBI, ^S5F0.SHPP)
                    Store (^SHBL, ^S5F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S5F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S5F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S5F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
        }

        Device (S5F0)
        {
            Name (_ADR, 0x00010000)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Name (_SUN, Ones)
            Name (SHPP, Ones)
            Name (SHPQ, Ones)
            Name (SHPS, Ones)
            Name (SHPX, Ones)
            Name (SHPY, Ones)
        }

        Device (S5F1)
        {
            Name (_ADR, 0x00010001)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Device (S5F2)
        {
            Name (_ADR, 0x00010002)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Device (S5F3)
        {
            Name (_ADR, 0x00010003)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Device (S5F4)
        {
            Name (_ADR, 0x00010004)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Device (S5F5)
        {
            Name (_ADR, 0x00010005)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Device (S5F6)
        {
            Name (_ADR, 0x00010006)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Device (S5F7)
        {
            Name (_ADR, 0x00010007)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S5F0._SUN)
            }
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.SUNC (0x05), Local0)
            Store (\_SB.VP00.ROWB (0x05), Local1)
            Store (\_SB.VP00.ROWS (0x05), Local2)
            SHPI (Zero, Local0, Local1, Local2)
        }
    }

    Scope (\_SB.VP07)
    {
        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB00), 
            SHBZ,   16, 
            Offset (0xB2F), 
            SHBD,   3, 
            Offset (0xB31), 
            SHBF,   1, 
            SHBG,   3, 
            Offset (0xB32), 
            SHBY,   5, 
            Offset (0xB33), 
            SHBE,   8, 
            Offset (0xB37), 
            SHBH,   8, 
            Offset (0xB3F), 
            SHBS,   8, 
            SHBT,   8, 
            SHBN,   1, 
            SHBO,   1, 
            SHBP,   1, 
            SHBQ,   1, 
            SHBR,   1, 
            Offset (0xB42), 
            SHBJ,   1, 
            SHBK,   1, 
            SHBL,   2, 
            SHBM,   2, 
            Offset (0xB43), 
            SHBI,   2
        }

        Field (PHBR, ByteAcc, NoLock, WriteAsZeros)
        {
            Offset (0xB2C), 
            SHRD,   3, 
            Offset (0xB30), 
            SHRE,   8, 
            SHRY,   5, 
            Offset (0xB32), 
            SHRF,   1, 
            SHRG,   3, 
            Offset (0xB34), 
            SHRH,   32, 
            Offset (0xB3C), 
            SHRS,   8, 
            Offset (0xB40), 
            SHRI,   2, 
            Offset (0xB41), 
            SHRJ,   1, 
            SHRK,   1, 
            SHRL,   2, 
            SHRM,   2, 
            Offset (0xB42), 
            SHRN,   1, 
            SHRO,   1, 
            SHRP,   1, 
            SHRQ,   1, 
            SHRR,   1, 
            Offset (0xB43), 
            SHRT,   8
        }

        Method (SHPC, 1, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                Store (Local1, ^SHRY)
                Store (Arg0, ^SHRE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHRF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHRF)
                {
                    BreakPoint
                }

                If (^SHRG)
                {
                    BreakPoint
                }
            }
            Else
            {
                Store (0x05DC, Local0)
                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                ShiftRight (Arg0, 0x08, Local1)
                If (LEqual (Local1, 0x00))
                {
                    Increment (Local1)
                }

                Store (Local1, ^SHBY)
                Store (Arg0, ^SHBE)
                If (LOr (LEqual (And (Arg0, 0xFF), 0x48), LEqual (And (Arg0, 0xFF), 0x49)))
                {
                    Store (0x05DC, Local0)
                }
                Else
                {
                    Store (0x64, Local0)
                }

                While (LAnd (^SHBF, Local0))
                {
                    Sleep (0x0A)
                    Decrement (Local0)
                }

                If (^SHBF)
                {
                    BreakPoint
                }

                If (^SHBG)
                {
                    BreakPoint
                }
            }
        }

        Method (SHPF, 0, Serialized)
        {
            ^WRK0 ()
            ^SHPC (Or (Or (0x0100, 0x03), Or (0x10, 0x0C)))
            \_SB.APCI.ZZZN
            ^S6F0.SHPX
            0xE0
            Store (0x03, ^S6F0.SHPP)
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRL, ^S6F0.SHPQ)
            }
            Else
            {
                Store (^SHBL, ^S6F0.SHPQ)
            }
        }

        Method (SHPE, 0, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                Store (^SHRH, Local0)
                While (Store (^SHRH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHRN)
                        {
                            Store (One, ^SHRN)
                            Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPX)), 0x0A))
                        }

                        If (^SHRO)
                        {
                            Store (One, ^SHRO)
                            BreakPoint
                        }

                        If (^SHRP)
                        {
                            Store (One, ^SHRP)
                        }

                        If (^SHRQ)
                        {
                            Store (One, ^SHRQ)
                            If (LNot (LEqual (^SHRI, 0x03)))
                            {
                                BreakPoint
                            }

                            ^WRK0 ()
                            If (LEqual (^S6F0.SHPP, 0x02))
                            {
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S6F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHRJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHRL, 0x03))
                                    {
                                        If (LNot (LEqual (^S6F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S6F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHRM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHRM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHRK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHRO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHRO)
                                            \_SB.APCI.ZZZN
                                            ^S6F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S6F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHRD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHRI, ^S6F0.SHPP)
                            Store (^SHRL, ^S6F0.SHPQ)
                        }

                        If (^SHRR)
                        {
                            Store (One, ^SHRR)
                            ^WRK0 ()
                            Store (One, ^SHRR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHRR)
                            \_SB.APCI.ZZZN
                            ^S6F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
            Else
            {
                Store (^SHBH, Local0)
                While (Store (^SHBH, Local1))
                {
                    If (And (Local1, 0x02))
                    {
                        If (^SHBN)
                        {
                            Store (One, ^SHBN)
                            Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPX)), 0x0A))
                        }

                        If (^SHBO)
                        {
                            Store (One, ^SHBO)
                            BreakPoint
                        }

                        If (^SHBP)
                        {
                            Store (One, ^SHBP)
                        }

                        If (^SHBQ)
                        {
                            Store (One, ^SHBQ)
                            If (LNot (LEqual (^SHBI, 0x03)))
                            {
                                BreakPoint
                            }

                            If (LEqual (^S6F0.SHPP, 0x02))
                            {
                                ^WRK0 ()
                                ^SHPC (Or (0x0100, Or (0x0C, 0x10)))
                                Notify (^, 0x00)
                                \_SB.APCI.ZZZN
                                ^S6F0.SHPX
                                0xEA
                            }
                            Else
                            {
                                If (LNot (^SHBJ))
                                {
                                    ^SHPC (Or (0x0100, 0x30))
                                    If (LEqual (^SHBL, 0x03))
                                    {
                                        If (LNot (LEqual (^S6F0.SHPQ, 0x03)))
                                        {
                                            \_SB.APCI.ZZZN
                                            ^S6F0.SHPX
                                            0xF1
                                        }
                                    }
                                    Else
                                    {
                                        ^SHPC (Or (0x0100, Or (0x04, 0x01)))
                                        If (LEqual (^SHBM, 0x03))
                                        {
                                            Store (0x44, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (^SHBM, 0x01))
                                            {
                                                Store (0x42, Local0)
                                            }
                                            Else
                                            {
                                                If (^SHBK)
                                                {
                                                    Store (0x41, Local0)
                                                }
                                                Else
                                                {
                                                    Store (0x40, Local0)
                                                }
                                            }
                                        }

                                        ^SHPC (Local0)
                                        Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPY)), 0x08))
                                        Sleep (0x1388)
                                        If (^SHBO)
                                        {
                                            ^WRK0 ()
                                            Store (One, SHRO)
                                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                                            Store (One, ^SHBO)
                                            \_SB.APCI.ZZZN
                                            ^S6F0.SHPX
                                            0xE9
                                        }
                                        Else
                                        {
                                            ^SHPC (Or (0x0100, 0x02))
                                            Sleep (0x0BB8)
                                            ^WRK1 ()
                                            \_SB.APCI.ZZZN
                                            ^S6F0.SHPX
                                            0xF0
                                            Notify (^, 0x00)
                                            Store (^SHBD, IOPT)
                                        }
                                    }
                                }
                            }

                            Store (^SHBI, ^S6F0.SHPP)
                            Store (^SHBL, ^S6F0.SHPQ)
                        }

                        If (^SHBR)
                        {
                            ^WRK0 ()
                            Store (One, ^SHBR)
                            ^SHPC (Or (Or (0x0C, 0x10), Or (0x0100, 0x03)))
                            Store (One, ^SHBR)
                            \_SB.APCI.ZZZN
                            ^S6F0.SHPX
                            0xE9
                        }
                    }
                    Else
                    {
                        BreakPoint
                    }
                }

                Return (Local0)
            }
        }

        Name (SHPB, Buffer (0x08)
        {
            0x00, 0x01, 0x05, 0x06, 0x07, 0xFF, 0xFF, 0xFF
        })
        Method (SHPI, 4, Serialized)
        {
            If (LEqual (^SHBZ, 0x1014))
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHRS)
                    Store (0x65, ^SHRT)
                    If (LNot (LEqual (^SHRI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S6F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHRD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S6F0.SHPX)
                    Store (ShiftLeft (^SHRL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S6F0.SHPS)
                    Store (Arg1, ^S6F0._SUN)
                    Store (^SHRI, ^S6F0.SHPP)
                    Store (^SHRL, ^S6F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S6F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S6F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (0x7E, ^SHBS)
                    Store (0x65, ^SHBT)
                    If (LNot (LEqual (^SHBI, 0x02)))
                    {
                        ^WRK0 ()
                    }

                    Store (Arg2, ^S6F0.SHPY)
                    Store (^_BBN (), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x05))
                    Store (DerefOf (Index (^SHPB, ^SHBD)), Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x08))
                    Store (0x81, Index (DerefOf (Index (\_SB.APCI.APCI, Arg2)), 0x00))
                    Store (Arg3, ^S6F0.SHPX)
                    Store (ShiftLeft (^SHBL, 0x03), Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0A))
                    Store (Arg1, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x0C))
                    Store (0x82, Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x00))
                    Store (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, Arg3)), 0x02)), ^S6F0.SHPS)
                    Store (Arg1, ^S6F0._SUN)
                    Store (^SHBI, ^S6F0.SHPP)
                    Store (^SHBL, ^S6F0.SHPQ)
                    Return (Increment (Arg1))
                }

                If (LEqual (Arg0, One))
                {
                    If (LEqual (^S6F0.SHPS, Arg1))
                    {
                        If (Arg2)
                        {
                            Store (0x20, Local0)
                            Store (0x08, Local1)
                        }
                        Else
                        {
                            If (DerefOf (Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPX)), 0x09)))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (0x30, Local0)
                            }

                            Store (Zero, Local1)
                        }

                        ^SHPC (Or (0x0100, Local0))
                        Store (Local1, Index (DerefOf (Index (\_SB.APCI.APCI, ^S6F0.SHPX)), 0x0B))
                        \_SB.APCI.ZZZN
                        ^S6F0.SHPX
                        0xF3
                    }
                }

                Return (Zero)
            }
        }

        Device (S6F0)
        {
            Name (_ADR, 0x00010000)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Name (_SUN, Ones)
            Name (SHPP, Ones)
            Name (SHPQ, Ones)
            Name (SHPS, Ones)
            Name (SHPX, Ones)
            Name (SHPY, Ones)
        }

        Device (S6F1)
        {
            Name (_ADR, 0x00010001)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Device (S6F2)
        {
            Name (_ADR, 0x00010002)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Device (S6F3)
        {
            Name (_ADR, 0x00010003)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Device (S6F4)
        {
            Name (_ADR, 0x00010004)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Device (S6F5)
        {
            Name (_ADR, 0x00010005)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Device (S6F6)
        {
            Name (_ADR, 0x00010006)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Device (S6F7)
        {
            Name (_ADR, 0x00010007)
            Method (_EJ0, 1, NotSerialized)
            {
                ^^SHPF ()
            }

            Method (_SUN, 0, NotSerialized)
            {
                Return (^^S6F0._SUN)
            }
        }

        Method (INIH, 0, NotSerialized)
        {
            Store (\_SB.VP00.SUNC (0x06), Local0)
            Store (\_SB.VP00.ROWB (0x06), Local1)
            Store (\_SB.VP00.ROWS (0x06), Local2)
            SHPI (Zero, Local0, Local1, Local2)
        }
    }
}


--=-HMf/HQDBSE2jf1j9dDas--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
