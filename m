From: Seunghun Han <kkamagui@gmail.com>
Subject: Re: [PATCH v2] acpi: acpica: fix acpi operand cache leak
Date: Fri, 24 Feb 2017 20:52:42 +0900
Message-ID: <CAHjaAcS1trmwY0kWQaohABE0xKxEo7wZdpc_pMaCgw0qyMgWug@mail.gmail.com>
References: <1487292003-25769-1-git-send-email-kkamagui@gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE3D1B6@SHSMSX101.ccr.corp.intel.com>
 <3623601.4MWzveC6R0@aspire.rjw.lan> <CAHjaAcRjYVmvo3vf04shYnYQ5upup31dSPTFwv7PtsQnp0mU-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHjaAcRjYVmvo3vf04shYnYQ5upup31dSPTFwv7PtsQnp0mU-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi, Lv Zheng.

I added my handcrafted ACPI table under your request, because
"acpidump -c on" and "acpidump -c off" doesn't work.

2017-02-21 19:36 GMT+09:00 Seunghun Han <kkamagui@gmail.com>:
> Hello,
>
> I attached the test results below,
>
> 2017-02-21 9:53 GMT+09:00 Rowafael J. Wysocki <rjw@rjwysocki.net>:
>> On Tuesday, February 21, 2017 12:33:08 AM Zheng, Lv wrote:
>>> Hi,
>>>
>>> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Seunghun
>>> > Han
>>> > Subject: [PATCH v2] acpi: acpica: fix acpi operand cache leak
>>> >
>>> > I'm Seunghun Han, and I work for National Security Research Institute of
>>> > South Korea.
>>> >
>>> > I have been doing a research on ACPI and making a handcrafted ACPI table
>>> > for my research.
>>> > Errors of handcrafted ACPI tables are handled well in Linux kernel while boot
>>> > process, and Linux kernel goes well without critical problems.
>>> > But I found some ACPI operand cache leaks in ACPI early abort cases.
>>> >
>>> > Boot log of ACPI operand cache leak is as follows:
>>> > >[    0.174332] ACPI: Added _OSI(Module Device)
>>> > >[    0.175504] ACPI: Added _OSI(Processor Device)
>>> > >[    0.176010] ACPI: Added _OSI(3.0 _SCP Extensions)
>>> > >[    0.177032] ACPI: Added _OSI(Processor Aggregator Device)
>>> > >[    0.178284] ACPI: SCI (IRQ16705) allocation failed
>>> > >[    0.179352] ACPI Exception: AE_NOT_ACQUIRED, Unable to install System Control Interrupt handler
>>> > (20160930/evevent-131)
>>> > >[    0.180008] ACPI: Unable to start the ACPI Interpreter
>>> > >[    0.181125] ACPI Error: Could not remove SCI handler (20160930/evmisc-281)
>>> > >[    0.184068] kmem_cache_destroy Acpi-Operand: Slab cache still has objects
>>> > >[    0.185358] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3 #2
>>> > >[    0.186820] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>> > >[    0.188000] Call Trace:
>>> > >[    0.188000]  ? dump_stack+0x5c/0x7d
>>> > >[    0.188000]  ? kmem_cache_destroy+0x224/0x230
>>> > >[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
>>> > >[    0.188000]  ? acpi_os_delete_cache+0xa/0xd
>>> > >[    0.188000]  ? acpi_ut_delete_caches+0x3f/0x7b
>>> > >[    0.188000]  ? acpi_terminate+0x5/0xf
>>> > >[    0.188000]  ? acpi_init+0x288/0x32e
>>> > >[    0.188000]  ? __class_create+0x4c/0x80
>>> > >[    0.188000]  ? video_setup+0x7a/0x7a
>>> > >[    0.188000]  ? do_one_initcall+0x4e/0x1b0
>>> > >[    0.188000]  ? kernel_init_freeable+0x194/0x21a
>>> > >[    0.188000]  ? rest_init+0x80/0x80
>>> > >[    0.188000]  ? kernel_init+0xa/0x100
>>> > >[    0.188000]  ? ret_from_fork+0x25/0x30
>>>
>>> I'm more interested in the way of triggering AE_NOT_ACQUIRED error.
>>> So could you send us the handcrafted ACPI table or both the "acpidump -c on" and "acpidump -c off" output?

I modified FACP, FACS, APIC table in VirtualBox for Linux.
Here are raw dumps of table.

[    0.000000] ACPI: FACP 0x00000000DFFF00F0 0000F4 (v04 VBOX
VBOXFACP 00000001 ASL  00000061)
[    0.000000] FACP DUMP
[    0.000000] 0x0000: 46 41 43 50 F4 00 00 00 04 60 56 42 4F 58 20 20
[    0.000000] 0x0010: 56 42 4F 58 46 41 43 50 01 00 00 00 41 53 4C 20
[    0.000000] 0x0020: 61 00 00 00 00 02 FF DF 80 04 FF DF 41 41 41 41
[    0.000000] 0x0030: 2E 44 00 00 A1 A0 00 00 00 40 00 00 00 00 00 00
[    0.000000] 0x0040: 04 40 00 00 00 00 00 00 00 00 00 00 08 40 00 00
[    0.000000] 0x0050: 20 40 00 00 00 00 00 00 04 02 00 04 02 00 00 00
[    0.000000] 0x0060: 65 00 E9 03 00 00 00 00 00 00 00 00 00 03 00 00
[    0.000000] 0x0070: 41 05 00 00 01 08 00 01 50 40 00 00 00 00 00 00
[    0.000000] 0x0080: 10 00 00 00 00 02 FF DF 00 00 00 00 80 04 FF DF
[    0.000000] 0x0090: 00 00 00 00 01 20 00 02 00 40 00 00 00 00 00 00
[    0.000000] 0x00A0: 00 00 00 00 00 00 00 00 00 00 00 00 01 10 00 02
[    0.000000] 0x00B0: 04 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] 0x00C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] 0x00D0: 01 20 00 03 08 40 00 00 00 00 00 00 01 10 00 01
[    0.000000] 0x00E0: 20 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] 0x00F0: 00 00 00 00

[    0.000000] ACPI: FACS 0x00000000DFFF0200 000040
[    0.000000] FACS DUMP
[    0.000000] 0x0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] 0x0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] 0x0020: 01 00 00 00 00 00 00 00 00 41 00 00 00 00 00 00
[    0.000000] 0x0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

[    0.000000] ACPI: FACS 0x00000000DFFF0200 000040
[    0.000000] FACS DUMP
[    0.000000] 0x0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] 0x0010: 00 00 00 00 00 00 00 00 00 41 41 41 41 41 41 41
[    0.000000] 0x0020: 01 00 00 00 00 00 00 00 00 41 00 00 00 00 00 00
[    0.000000] 0x0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

[    0.000000] ACPI: APIC 0x00000000DFFF0240 00006C (v02 VBOX
VBOXAPIC 00000001 ASL  00000061)
[    0.000000] APIC DUMP
[    0.000000] 0x0000: 41 50 49 43 6C 00 00 00 02 21 56 42 4F 58 20 20
[    0.000000] 0x0010: 56 42 4F 58 41 50 49 43 01 00 00 00 41 53 4C 20
[    0.000000] 0x0020: 61 00 00 00 00 00 E0 FE 01 00 00 00 02 0A 00 00
[    0.000000] 0x0030: 02 00 00 00 00 00 02 0A 00 09 09 00 00 00 0D 00
[    0.000000] 0x0040: 00 08 00 00 01 00 41 41 41 41 41 41 41 41 41 00
[    0.000000] 0x0050: 00 08 02 02 01 00 00 00 00 08 03 03 01 00 00 00
[    0.000000] 0x0060: 01 0C 04 00 00 00 C0 FE 00 00 00 00

If you need additional data, please let me know.
Thank you.

Best regards.

>
> Because of the ACPI interpreter error, ACPI function were terminated,
> so there is no directory "/proc/acpi".
> And when I typed the acpidump command, errors were shown.
>
> The error are as follows.
> root@debian:/proc# acpidump -c on
> Cannot open directory - /sys/firmware/acpi/tables
> Could not get ACPI tables, AE_NOT_FOUND
>
> root@debian:/proc# acpidump -c off
> Cannot open directory - /sys/firmware/acpi/tables
> Could not get ACPI tables, AE_NOT_FOUND
>
> Could you tell me another way to get information for you?
> Thank you.
>
> Best regards.
>
>>> >
>>> > When early abort is occurred due to invalid ACPI information, Linux kernel
>>> > terminates ACPI by calling acpi_terminate() function.
>>> > The function calls acpi_ns_terminate() function to delete namespace data
>>> > and ACPI operand cache (acpi_gbl_module_code_list).
>>> >
>>> > But the deletion code in acpi_ns_terminate() function is wrapped in
>>> > ACPI_EXEC_APP definition, therefore the code is only executed when the
>>> > definition exists.
>>> > If the define doesn't exist, ACPI operand cache (acpi_gbl_module_code_list) is
>>> > leaked, and stack dump is shown in kernel log.
>>> >
>>>
>>> acpi_ns_terminate() actually shouldn't be invoked by Linux.
>>> It's not fully functioning in Linux kernel environment.
>>>
>>> > This causes a security threat because the old kernel (<= 4.9) shows memory
>>> > locations of kernel functions in stack dump, therefore kernel ASLR can be
>>> > neutralized.
>>> >
>>> > To fix ACPI operand leak for enhancing security, I made a patch which removes
>>> > the ACPI_EXEC_APP define in acpi_ns_terminate() function for executing the
>>> > deletion code unconditionally.
>>>
>>> However acpi_gbl_module_code_list deletion shouldn't be dependent on ACPI_EXEC_APP.
>>> So your change is acceptable.
>>>
>>> >
>>> > I hope that this patch improves the security of Linux kernel.
>>> >
>>> > Thank you.
>>> >
>>> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
>>> > ---
>>> > Changes since v1: move position of variables to remove compile warning.
>>> >
>>> > drivers/acpi/acpica/nsutils.c | 23 +++++++++--------------
>>> >  1 file changed, 9 insertions(+), 14 deletions(-)
>>> >
>>> > diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
>>> > index 691814d..943702d 100644
>>> > --- a/drivers/acpi/acpica/nsutils.c
>>> > +++ b/drivers/acpi/acpica/nsutils.c
>>> > @@ -594,25 +594,20 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle)
>>> >  void acpi_ns_terminate(void)
>>> >  {
>>> >     acpi_status status;
>>> > +   union acpi_operand_object *prev;
>>> > +   union acpi_operand_object *next;
>>> >
>>> >     ACPI_FUNCTION_TRACE(ns_terminate);
>>> >
>>> > -#ifdef ACPI_EXEC_APP
>>> > -   {
>>> > -           union acpi_operand_object *prev;
>>> > -           union acpi_operand_object *next;
>>> > +   /* Delete any module-level code blocks */
>>> >
>>> > -           /* Delete any module-level code blocks */
>>> > -
>>> > -           next = acpi_gbl_module_code_list;
>>> > -           while (next) {
>>> > -                   prev = next;
>>> > -                   next = next->method.mutex;
>>> > -                   prev->method.mutex = NULL;      /* Clear the Mutex (cheated) field */
>>> > -                   acpi_ut_remove_reference(prev);
>>> > -           }
>>> > +   next = acpi_gbl_module_code_list;
>>> > +   while (next) {
>>> > +           prev = next;
>>> > +           next = next->method.mutex;
>>> > +           prev->method.mutex = NULL;      /* Clear the Mutex (cheated) field */
>>> > +           acpi_ut_remove_reference(prev);
>>> >     }
>>> > -#endif
>>>
>>> Thus this looks OK to me.
>>>
>>> >
>>> >     /*
>>> >      * Free the entire namespace -- all nodes and all objects
>>> > --
>>> > 2.1.4
>>
>> I still would prefer it to go in via the upstream.
>>
>> Thanks,
>> Rafael
>>
