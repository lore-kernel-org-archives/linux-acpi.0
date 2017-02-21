From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi: acpica: fix acpi operand cache leak
Date: Tue, 21 Feb 2017 01:53:58 +0100
Message-ID: <3623601.4MWzveC6R0@aspire.rjw.lan>
References: <1487292003-25769-1-git-send-email-kkamagui@gmail.com> <1AE640813FDE7649BE1B193DEA596E886CE3D1B6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54005 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750925AbdBUA7C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Feb 2017 19:59:02 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE3D1B6@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Seunghun Han <kkamagui@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Robert Moore <robert.moore@intel.com>

On Tuesday, February 21, 2017 12:33:08 AM Zheng, Lv wrote:
> Hi,
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Seunghun
> > Han
> > Subject: [PATCH v2] acpi: acpica: fix acpi operand cache leak
> > 
> > I'm Seunghun Han, and I work for National Security Research Institute of
> > South Korea.
> > 
> > I have been doing a research on ACPI and making a handcrafted ACPI table
> > for my research.
> > Errors of handcrafted ACPI tables are handled well in Linux kernel while boot
> > process, and Linux kernel goes well without critical problems.
> > But I found some ACPI operand cache leaks in ACPI early abort cases.
> > 
> > Boot log of ACPI operand cache leak is as follows:
> > >[    0.174332] ACPI: Added _OSI(Module Device)
> > >[    0.175504] ACPI: Added _OSI(Processor Device)
> > >[    0.176010] ACPI: Added _OSI(3.0 _SCP Extensions)
> > >[    0.177032] ACPI: Added _OSI(Processor Aggregator Device)
> > >[    0.178284] ACPI: SCI (IRQ16705) allocation failed
> > >[    0.179352] ACPI Exception: AE_NOT_ACQUIRED, Unable to install System Control Interrupt handler
> > (20160930/evevent-131)
> > >[    0.180008] ACPI: Unable to start the ACPI Interpreter
> > >[    0.181125] ACPI Error: Could not remove SCI handler (20160930/evmisc-281)
> > >[    0.184068] kmem_cache_destroy Acpi-Operand: Slab cache still has objects
> > >[    0.185358] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3 #2
> > >[    0.186820] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> > >[    0.188000] Call Trace:
> > >[    0.188000]  ? dump_stack+0x5c/0x7d
> > >[    0.188000]  ? kmem_cache_destroy+0x224/0x230
> > >[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
> > >[    0.188000]  ? acpi_os_delete_cache+0xa/0xd
> > >[    0.188000]  ? acpi_ut_delete_caches+0x3f/0x7b
> > >[    0.188000]  ? acpi_terminate+0x5/0xf
> > >[    0.188000]  ? acpi_init+0x288/0x32e
> > >[    0.188000]  ? __class_create+0x4c/0x80
> > >[    0.188000]  ? video_setup+0x7a/0x7a
> > >[    0.188000]  ? do_one_initcall+0x4e/0x1b0
> > >[    0.188000]  ? kernel_init_freeable+0x194/0x21a
> > >[    0.188000]  ? rest_init+0x80/0x80
> > >[    0.188000]  ? kernel_init+0xa/0x100
> > >[    0.188000]  ? ret_from_fork+0x25/0x30
> 
> I'm more interested in the way of triggering AE_NOT_ACQUIRED error.
> So could you send us the handcrafted ACPI table or both the "acpidump -c on" and "acpidump -c off" output?
> 
> > 
> > When early abort is occurred due to invalid ACPI information, Linux kernel
> > terminates ACPI by calling acpi_terminate() function.
> > The function calls acpi_ns_terminate() function to delete namespace data
> > and ACPI operand cache (acpi_gbl_module_code_list).
> > 
> > But the deletion code in acpi_ns_terminate() function is wrapped in
> > ACPI_EXEC_APP definition, therefore the code is only executed when the
> > definition exists.
> > If the define doesn't exist, ACPI operand cache (acpi_gbl_module_code_list) is
> > leaked, and stack dump is shown in kernel log.
> > 
> 
> acpi_ns_terminate() actually shouldn't be invoked by Linux.
> It's not fully functioning in Linux kernel environment.
> 
> > This causes a security threat because the old kernel (<= 4.9) shows memory
> > locations of kernel functions in stack dump, therefore kernel ASLR can be
> > neutralized.
> > 
> > To fix ACPI operand leak for enhancing security, I made a patch which removes
> > the ACPI_EXEC_APP define in acpi_ns_terminate() function for executing the
> > deletion code unconditionally.
> 
> However acpi_gbl_module_code_list deletion shouldn't be dependent on ACPI_EXEC_APP.
> So your change is acceptable.
> 
> > 
> > I hope that this patch improves the security of Linux kernel.
> > 
> > Thank you.
> > 
> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> > ---
> > Changes since v1: move position of variables to remove compile warning.
> > 
> > drivers/acpi/acpica/nsutils.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
> > index 691814d..943702d 100644
> > --- a/drivers/acpi/acpica/nsutils.c
> > +++ b/drivers/acpi/acpica/nsutils.c
> > @@ -594,25 +594,20 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle)
> >  void acpi_ns_terminate(void)
> >  {
> >  	acpi_status status;
> > +	union acpi_operand_object *prev;
> > +	union acpi_operand_object *next;
> > 
> >  	ACPI_FUNCTION_TRACE(ns_terminate);
> > 
> > -#ifdef ACPI_EXEC_APP
> > -	{
> > -		union acpi_operand_object *prev;
> > -		union acpi_operand_object *next;
> > +	/* Delete any module-level code blocks */
> > 
> > -		/* Delete any module-level code blocks */
> > -
> > -		next = acpi_gbl_module_code_list;
> > -		while (next) {
> > -			prev = next;
> > -			next = next->method.mutex;
> > -			prev->method.mutex = NULL;	/* Clear the Mutex (cheated) field */
> > -			acpi_ut_remove_reference(prev);
> > -		}
> > +	next = acpi_gbl_module_code_list;
> > +	while (next) {
> > +		prev = next;
> > +		next = next->method.mutex;
> > +		prev->method.mutex = NULL;	/* Clear the Mutex (cheated) field */
> > +		acpi_ut_remove_reference(prev);
> >  	}
> > -#endif
> 
> Thus this looks OK to me.
> 
> > 
> >  	/*
> >  	 * Free the entire namespace -- all nodes and all objects
> > --
> > 2.1.4

I still would prefer it to go in via the upstream.

Thanks,
Rafael

