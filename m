From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 05/14] ACPICA: Debugger: Prevent possible command line
 buffer overflow.
Date: Mon, 16 Sep 2013 20:42:38 -0400
Message-ID: <CAJvTdKmdXehe=fy-p+_gktaPBQYH_XWUd=PbCybVK-SVQ=Uiqg@mail.gmail.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
	<31cb81fe6434a1cbb35360798d3f8f8579350e5d.1377844863.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46719 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3IQAml (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Sep 2013 20:42:41 -0400
Received: by mail-wi0-f170.google.com with SMTP id cb5so4292352wib.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Sep 2013 17:42:40 -0700 (PDT)
In-Reply-To: <31cb81fe6434a1cbb35360798d3f8f8579350e5d.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, Sep 12, 2013 at 4:54 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Bob Moore <robert.moore@intel.com>
>
> Increase the size of a couple of the debugger line buffers.
> ACPICA BZ 1037.
>
> Buglink: http://bugs.acpica.org/show_bug.cgi?id=1037
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/acglobal.h |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
> index 90e846f..c9ad2e1 100644
> --- a/drivers/acpi/acpica/acglobal.h
> +++ b/drivers/acpi/acpica/acglobal.h
> @@ -445,13 +445,6 @@ ACPI_EXTERN u8 acpi_gbl_db_opt_tables;
>  ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
>  ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
>  ACPI_EXTERN u8 acpi_gbl_db_opt_no_region_support;
> -
> -ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
> -ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
> -ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
> -ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
> -ACPI_EXTERN char acpi_gbl_db_scope_buf[80];
> -ACPI_EXTERN char acpi_gbl_db_debug_filename[80];

If I read the code correctly, these are all inside #ifdefs that are
not defined in kernel mode,
and so the kernel will not be impacted by this buffer growth from 80 to 512,
and this patch is just to keep shared w/ acpiexec the same, yes?

thanks,
Len Brown, Intel Open Source Technology Center

>  ACPI_EXTERN u8 acpi_gbl_db_output_to_file;
>  ACPI_EXTERN char *acpi_gbl_db_buffer;
>  ACPI_EXTERN char *acpi_gbl_db_filename;
> @@ -459,6 +452,16 @@ ACPI_EXTERN u32 acpi_gbl_db_debug_level;
>  ACPI_EXTERN u32 acpi_gbl_db_console_debug_level;
>  ACPI_EXTERN struct acpi_namespace_node *acpi_gbl_db_scope_node;
>
> +ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
> +ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
> +
> +/* These buffers should all be the same size */
> +
> +ACPI_EXTERN char acpi_gbl_db_line_buf[ACPI_DB_LINE_BUFFER_SIZE];
> +ACPI_EXTERN char acpi_gbl_db_parsed_buf[ACPI_DB_LINE_BUFFER_SIZE];
> +ACPI_EXTERN char acpi_gbl_db_scope_buf[ACPI_DB_LINE_BUFFER_SIZE];
> +ACPI_EXTERN char acpi_gbl_db_debug_filename[ACPI_DB_LINE_BUFFER_SIZE];
> +
>  /*
>   * Statistic globals
>   */
> --
> 1.7.10
