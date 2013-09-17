From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 05/14] ACPICA: Debugger: Prevent possible command line
 buffer overflow.
Date: Tue, 17 Sep 2013 01:15:23 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802463FB4@SHSMSX101.ccr.corp.intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<31cb81fe6434a1cbb35360798d3f8f8579350e5d.1377844863.git.lv.zheng@intel.com>
 <CAJvTdKmdXehe=fy-p+_gktaPBQYH_XWUd=PbCybVK-SVQ=Uiqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10867 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab3IQBP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 21:15:27 -0400
In-Reply-To: <CAJvTdKmdXehe=fy-p+_gktaPBQYH_XWUd=PbCybVK-SVQ=Uiqg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Len Brown
> Sent: Tuesday, September 17, 2013 8:43 AM
> 
> On Thu, Sep 12, 2013 at 4:54 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > From: Bob Moore <robert.moore@intel.com>
> >
> > Increase the size of a couple of the debugger line buffers.
> > ACPICA BZ 1037.
> >
> > Buglink: http://bugs.acpica.org/show_bug.cgi?id=1037
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> >  drivers/acpi/acpica/acglobal.h |   17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
> > index 90e846f..c9ad2e1 100644
> > --- a/drivers/acpi/acpica/acglobal.h
> > +++ b/drivers/acpi/acpica/acglobal.h
> > @@ -445,13 +445,6 @@ ACPI_EXTERN u8 acpi_gbl_db_opt_tables;
> >  ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
> >  ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
> >  ACPI_EXTERN u8 acpi_gbl_db_opt_no_region_support;
> > -
> > -ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
> > -ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
> > -ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
> > -ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
> > -ACPI_EXTERN char acpi_gbl_db_scope_buf[80];
> > -ACPI_EXTERN char acpi_gbl_db_debug_filename[80];
> 
> If I read the code correctly, these are all inside #ifdefs that are
> not defined in kernel mode,
> and so the kernel will not be impacted by this buffer growth from 80 to 512,
> and this patch is just to keep shared w/ acpiexec the same, yes?

Yes, the codes belongs to the AML debugger which is defined by ACPI specification, implemented in the ACPICA but not shipped in the Linux kernel.
We've a plan to port the debugger/disassmebler to the kernel.
So it's likely we'll see users of such globals in the kernel tree.
Currently, kernel behaviors are not affected by this patch.

And, if we delete the piece of codes like this, then it will generate new source code differences between Linux and ACPICA, which will hurt the automation of the ACPICA release process.
I'm sorry for that.

Thanks and best regards
-Lv
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> >  ACPI_EXTERN u8 acpi_gbl_db_output_to_file;
> >  ACPI_EXTERN char *acpi_gbl_db_buffer;
> >  ACPI_EXTERN char *acpi_gbl_db_filename;
> > @@ -459,6 +452,16 @@ ACPI_EXTERN u32 acpi_gbl_db_debug_level;
> >  ACPI_EXTERN u32 acpi_gbl_db_console_debug_level;
> >  ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_db_scope_node;
> >
> > +ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
> > +ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
> > +
> > +/* These buffers should all be the same size */
> > +
> > +ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
> > +ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
> > +ACPI_EXTERN char acpi_gbl_db_scope_buf[ACPI_DB_LINE_BUFFER_SIZE];
> > +ACPI_EXTERN char acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE];
> > +
> >  /*
> >   * Statistic globals
> >   */
> > --
> > 1.7.10
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
