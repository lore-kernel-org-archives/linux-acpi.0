From: Stuart_Hayes-DYMqY+WieiM@public.gmane.org
Subject: RE: stack overflow
Date: Wed, 10 Mar 2004 09:56:42 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA6@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Here is the relevant method, and all of the fields, regions, and
methods needed to execute it (I think).  If this isn't sufficient,
let me know.  The method being run is ...VPR0.D0F0._STA.

This is cut from the output from Phoenix's "ad" program, and it is=20
showing both the disassembled code and the AML itself.  Sorry about
the long lines.

Thanks
Stuart

    Scope/*0x10*//*0x85,0x31,0x03*/(\_SB/*0x5C,0x5F,0x53,0x42,0x5F*/)
    {
=20
Device/*0x5B,0x82*//*0x8D,0xD0,0x02*/(PCI0/*0x50,0x43,0x49,0x30*/)
        {
=20
Device/*0x5B,0x82*//*0x4C,0x89*/(VPR0/*0x56,0x50,0x52,0x30*/)
            {
=20
Name/*0x08*/(DEVN/*0x44,0x45,0x56,0x4E*/,/*0x0A*/0x00/*0x00*/)
=20
Method/*0x14*//*0x3B*/(_ADR/*0x5F,0x41,0x44,0x52*/,0,NotSerialized/*0x00
*/)
                {
=20
Store/*0x70*/(/*0x0C*/0x00060000/*0x00,0x00,0x06,0x00*/,Local0/*0x60*/)
=20
Store/*0x70*/(\_SB.PCI0.ISA.CPTP/*0x5C,0x2F,0x04,0x5F,0x53,0x42,0x5F,0x5
0,0x43,0x49,0x30,0x49,0x53,0x41,0x5F,0x43,0x50,0x54,0x50*/,Local1/*0x61*
/)
=20
If/*0xA0*//*0x0C*/(LEqual/*0x93*/(Local1/*0x61*/,/*0x0A*/0x01/*0x01*/))
                    {
=20
Store/*0x70*/(/*0x0C*/0x000A0000/*0x00,0x00,0x0A,0x00*/,Local0/*0x60*/)
                    }
=20
Store/*0x70*/(Local0/*0x60*/,DEVN/*0x44,0x45,0x56,0x4E*/ /*
\_SB.PCI0.VPR0.DEVN */)
                    Store/*0x70*/(Local0/*0x60*/,Debug/*0x5B,0x31*/)
                    Return/*0xA4*/(Local0/*0x60*/)
                }
=20
Method/*0x14*//*0x21*/(MADR/*0x4D,0x41,0x44,0x52*/,1,NotSerialized/*0x01
*/)
                {
                    Store/*0x70*/(Arg0/*0x68*/,Local0/*0x60*/)
=20
If/*0xA0*//*0x0B*/(And/*0x7B*/(SCPL/*0x53,0x43,0x50,0x4C*/ /*
\_SB.PCI0.VPR0.SCPL */,/*0x0A*/0x40/*0x40*//*0x00*/))
                    {
                        Return/*0xA4*/(Local0/*0x60*/)
                    }
                    Else/*0xA1*//*0x0B*/
                    {
=20
Or/*0x7D*/(Local0/*0x60*/,/*0x0C*/0x001F0000/*0x00,0x00,0x1F,0x00*/,Loca
l0/*0x60*/)
                        Return/*0xA4*/(Local0/*0x60*/)
                    }
                }

                OperationRegion(NBCF,PCI_Config,0x00,0x0100)
                Field(NBCF /* \_SB.PCI0.VPR0.NBCF
*/,ByteAcc,NoLock,Preserve)
                {
                    Offset(0x70),
                    Offset(0x73),
                    PNUM,8,
                    Offset(0x78),
                    SCPL,16,
                    SCPH,16,
                    SCTL,8,
                    SCTH,8,
                    SSTA,8,
                    Offset(0x80),
                    RPCT,8
                }


=20
Method/*0x14*//*0x15*/(MSTA/*0x4D,0x53,0x54,0x41*/,1,NotSerialized/*0x01
*/)
                {
=20
If/*0xA0*//*0x09*/(LEqual/*0x93*/(Arg0/*0x68*/,/*0x0B*/0xFFFF/*0xFF,0xFF
*/))
                    {
                        Return/*0xA4*/(/*0x0A*/0x00/*0x00*/)
                    }
                    Else/*0xA1*//*0x04*/
                    {
                        Return/*0xA4*/(/*0x0A*/0x0F/*0x0F*/)
                    }
                }

=20
Device/*0x5B,0x82*//*0x4C,0x05*/(D0F0/*0x44,0x30,0x46,0x30*/)
                {
=20
Method/*0x14*//*0x0D*/(_ADR/*0x5F,0x41,0x44,0x52*/,0,NotSerialized/*0x00
*/)
                    {
                        Return/*0xA4*/(MADR/*0x4D,0x41,0x44,0x52*/ /*
\_SB.PCI0.VPR0.MADR */(/*0x0A*/0x00/*0x00*/))
                    }
=20
Method/*0x14*//*0x0F*/(_SUN/*0x5F,0x53,0x55,0x4E*/,0,NotSerialized/*0x00
*/)
                    {
=20
Return/*0xA4*/(ShiftRight/*0x7A*/(SCPH/*0x53,0x43,0x50,0x48*/ /*
\_SB.PCI0.VPR0.SCPH */,/*0x0A*/0x03/*0x03*//*0x00*/))
                    }
=20
OperationRegion/*0x5B,0x80*/(SCFG/*0x53,0x43,0x46,0x47*/,PCI_Config/*0x0
2*/,/*0x0A*/0x00/*0x00*/,/*0x0B*/0x0100/*0x00,0x01*/)
=20
Field/*0x5B,0x81*//*0x0B*/(SCFG/*0x53,0x43,0x46,0x47*/ /*
\_SB.PCI0.VPR0.D0F0.SCFG */,WordAcc,NoLock,Preserve/*0x02*/)
                    {
                        VDID/*0x56,0x44,0x49,0x44*//*0x10*/,16
                    }
=20
Method/*0x14*//*0x0F*/(_STA/*0x5F,0x53,0x54,0x41*/,0,NotSerialized/*0x00
*/)
                    {
                        Return/*0xA4*/(MSTA/*0x4D,0x53,0x54,0x41*/ /*
\_SB.PCI0.VPR0.MSTA */(VDID/*0x56,0x44,0x49,0x44*/ /*
\_SB.PCI0.VPR0.D0F0.VDID */))
                    }
=20
Method/*0x14*//*0x0E*/(_EJ0/*0x5F,0x45,0x4A,0x30*/,1,NotSerialized/*0x01
*/)
                    {
                        PWCM/*0x50,0x57,0x43,0x4D*/ /*
\_SB.PCI0.VPR0.PWCM */(/*0x0A*/0xF8/*0xF8*/,/*0x0A*/0x07/*0x07*/)
                    }
                }
            }
        }
    }






Moore, Robert wrote:
> Can you please post your DSDT and give us some idea of which _STA
> method is executing?
>=20
> I seem to remember that there may be a bit of leftover recursion in
> the operation region/field handling code, but something looks very
> odd about the way the ev_pci_config_region_setup function is getting
> called twice.=20
>=20
>=20
>>> It seems to work with CONFIG_ACPI_DEBUG off.  I'm guessing we're
>>> just=20
> squeaking by with that, though.  Wouldn't more complex ACPI methods
> cause the stack usage to go up, causing it to break again?
>=20
> I think this is an odd case (i.e., bug), since the interpreter has
> been specifically architected to not use recursion -- however, the
> original version of the interpreter did recurse based on the
> complexity of the ASL code (when the interpreter was running as an
> application.)  This was removed in all obvious cases, but I do think
> that there may be a couple that were missed - fields being perhaps
> one of them.=20
>=20
> Bob
>=20
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
> Stuart_Hayes-DYMqY+WieiM@public.gmane.org
> Sent: Tuesday, March 09, 2004 12:00 PM
> To: Brown, Len; ak-l3A5Bk7waGM@public.gmane.org
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] stack overflow
>=20
>=20
> I am in the process of trying this without CONFIG_ACPI_DEBUG now.
>=20
> I put a little extra debug stuff in utilities/utdebug.c to keep track
> of all the nested functions, and added the ACPI_FUNCTION_TRACE to some
> more of the functions, and this is what I get when the stack pointer
> is lowest (the number by each is the address of the first argument of
> the acpi_ut_trace(_*) function, which I store along with the function
> name).  This gives a pretty good picture of what's going on with the
> recursion and the deep nesting of functions.
>=20
>   acpi_init 			0000010001e0defc
>   acpi_bus_init 			0000010001e0deac
>   acpi_initialize_objects 	0000010001e0de6c
>   ns_initialize_devices 	0000010001e0de1c
>   ns_walk_namespace 		0000010001e0dd8c
>   ns_init_one_device 		0000010001e0dd2c
>   ut_execute_STA 			0000010001e0dccc
>   ut_evaluate_object 		0000010001e0dc5c
>   ns_evaluate_relative 		0000010001e0db8c
>   ns_evaluate_by_handle 	0000010001e0db1c
>   ns_execute_control_method 	0000010001e0dacc
>   psx_execute 			0000010001e0da5c
>   ps_parse_aml 			0000010001e0da0c
>   ps_parse_loop 			0000010001e0d8fc
>   ds_exec_end_op 			0000010001e0d89c
>   ds_resolve_operands 		0000010001e0d85c
>   ex_resolve_to_value 		0000010001e0d80c
>   ex_resolve_node_to_value 	0000010001e0d7ac
>   ex_read_data_from_field 	0000010001e0d71c
>   ex_extract_from_field 	0000010001e0d69c
>   ex_field_datum_io 		0000010001e0d61c
>   ex_access_region 		0000010001e0d5ac
>   ev_address_space_dispatch 	0000010001e0d52c
>   ev_pci_config_region_setup 	0000010001e0d4ac
>   ut_evaluate_numeric_object 	0000010001e0d44c
>   ut_evaluate_object 		0000010001e0d3dc
>   ns_evaluate_relative 		0000010001e0d30c
>   ns_evaluate_by_handle 	0000010001e0d29c
>   ns_execute_control_method 	0000010001e0d24c
>   psx_execute 			0000010001e0d1dc
>   ps_parse_aml 			0000010001e0d18c
>   ps_parse_loop 			0000010001e0d07c
>   ds_exec_end_op 			0000010001e0d01c
>   ex_resolve_operands 		0000010001e0cf9c
>   ex_resolve_to_value 		0000010001e0cf4c
>   ex_resolve_node_to_value 	0000010001e0ceec
>   ex_read_data_from_field 	0000010001e0ce5c
>   ex_extract_from_field 	0000010001e0cddc
>   ex_field_datum_io 		0000010001e0cd5c
>   ex_access_region 		0000010001e0ccec
>   ev_address_space_dispatch 	0000010001e0cc6c
>   ev_pci_config_region_setup 	0000010001e0cbec
>   acpi_evaluate_integer 	0000010001e0caac
>   acpi_evaluate_object 		0000010001e0ca2c
>   ns_evaluate_relative 		0000010001e0c95c
>   ns_evaluate_by_handle 	0000010001e0c8ec
>   ns_execute_control_method 	0000010001e0c89c
>   psx_execute 			0000010001e0c82c
>   ps_parse_aml 			0000010001e0c7dc
>   ps_parse_loop 			0000010001e0c6cc
>   ds_exec_end_op 			0000010001e0c66c
>   ex_resolve_operands 		0000010001e0c5ec
>   ex_resolve_to_value 		0000010001e0c59c
>   ex_resolve_node_to_value 	0000010001e0c53c
>   ex_read_data_from_field 	0000010001e0c4ac
>   ex_extract_from_field 	0000010001e0c42c
>   ex_field_datum_io 		0000010001e0c3ac
>   ex_access_region 		0000010001e0c33c
>   ev_address_space_dispatch 	0000010001e0c2bc
>   ex_enter_interpreter 		0000010001e0c27c
>   ut_acquire_mutex 		0000010001e0c21c
>   os_wait_semaphore 		0000010001e0c1cc
>=20
> Thanks
> Stuart
>=20
>=20
>=20
> Len Brown wrote:
>> Stuart,
>> Does CONFIG_ACPI_DEBUG change the results of your measurements?
>>=20
>> Is it possible to run an i386 kernel on the same system to see if
>> we've got an x86_64-specific issue?
>>=20
>> There is some run-time stack tracing code in ACPI (see
>> acpi_gbl_lowest_stack_pointer) but it hasn't been used in a while.
>>=20
>> thanks,
>> -Len
>>=20
>> On Mon, 2004-03-08 at 13:26, Andi Kleen wrote:
>>>> Here are some of the reasons I believe the stack is overflowing:
>>>>=20
>>>> I've added some "printk"s to the kernel, and I've found that the
>>>> stack pointer goes down by ~6K between
>>>> namespace/nseval.c:acpi_ns_evaluate_relative() and
>>>> executer/exstore.c:acpi_ex_store().
>>>=20
>>> The usual way to start is do
>>>=20
>>> 	objdump -S <acpi object modules> | grep sub.*rsp
>>>=20
>>> then sort by the biggest stack pigs and fix them one by one (e.g.
>>> by kmallocing local data instead of allocating it on the stack)
>>> When afterwards the problem still occurs it is most likely recursion
>>> or to deep nesting.  I have an old 2.4 patch that can catch these,
>>> but it would need porting to 2.6.
>>>=20
>>> -Andi
>>>=20
>>>=20
>>> -------------------------------------------------------
>>> This SF.Net email is sponsored by: IBM Linux Tutorials
>>> Free Linux tutorial presented by Daniel Robbins, President and CEO
>>> of GenToo technologies. Learn everything from fundamentals to system
>>>
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
>>> _______________________________________________
>>> Acpi-devel mailing list
>>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
