From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ACPICA: Log Exceptions and Errors as warning while
 loading extra tables
Date: Fri, 12 Jan 2018 11:25:34 +0100
Message-ID: <134f554a-8693-0c8c-dd5e-7ee9a8b369df@redhat.com>
References: <20180111192841.7951-1-hdegoede@redhat.com>
 <20180111192841.7951-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35249 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbeALKZh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jan 2018 05:25:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so10883405wme.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jan 2018 02:25:36 -0800 (PST)
In-Reply-To: <20180111192841.7951-2-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org

Hi,

On 11-01-18 20:28, Hans de Goede wrote:
> Honor the "Ignore errors while loading tables, get as many as possible"
> comment in the tbxfload.c code and log any exceptions and errors during
> loading extra tables as warnings.
> 
> This is important because many desktop and embedded applicance Linux
> use-cases have a hard requirement of not showing any (scary) text
> messages during system bootup, which get broken by errors reported
> by attempts to load the extra tables, as messaged logged at a KERN_ERR
> level are always shown even if the quiet kernel cmdline option is used.
> 
> Ideally all ACPI tables would be free of errors, but in practice that
> is just not the case and vendors are not always willing / responsive
> to fixing issues.
> 
> Note this commit only lowers the loglevel while loading extra / optional
> tables from acpi_tb_load_namespace() all other parsing errors are still
> logged with a loglevel of error.
> 
> BugLink: http://en.community.dell.com/techcenter/os-applications/f/4457/t/20006889
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109511
> Related: https://bugzilla.kernel.org/show_bug.cgi?id=198167
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I ended up looking at this again today and specifically also at
fixing https://bugzilla.kernel.org/show_bug.cgi?id=198167.

I believe I've a cleaner fix without the global flag for this, I will
post a new series replacing this patch later today,

Regards,

Hans


> ---
>   drivers/acpi/acpica/acglobal.h  |  1 +
>   drivers/acpi/acpica/tbxfload.c  |  4 +++-
>   drivers/acpi/acpica/uterror.c   | 10 ++++++++--
>   drivers/acpi/acpica/utxferror.c | 19 ++++++++++---------
>   4 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
> index 95eed442703f..7cb2ee8ce945 100644
> --- a/drivers/acpi/acpica/acglobal.h
> +++ b/drivers/acpi/acpica/acglobal.h
> @@ -146,6 +146,7 @@ ACPI_GLOBAL(acpi_cache_t *, acpi_gbl_operand_cache);
>   ACPI_INIT_GLOBAL(u32, acpi_gbl_startup_flags, 0);
>   ACPI_INIT_GLOBAL(u8, acpi_gbl_shutdown, TRUE);
>   ACPI_INIT_GLOBAL(u8, acpi_gbl_early_initialization, TRUE);
> +ACPI_INIT_GLOBAL(u8, acpi_gbl_log_errors_exceptions_as_warnings, FALSE);
>   
>   /* Global handlers */
>   
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index d81f442228b8..a1eaa69d0749 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -217,6 +217,7 @@ acpi_status acpi_tb_load_namespace(void)
>   		}
>   
>   		/* Ignore errors while loading tables, get as many as possible */
> +		acpi_gbl_log_errors_exceptions_as_warnings = TRUE;
>   
>   		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
>   		status = acpi_ns_load_table(i, acpi_gbl_root_node);
> @@ -237,11 +238,12 @@ acpi_status acpi_tb_load_namespace(void)
>   			tables_loaded++;
>   		}
>   	}
> +	acpi_gbl_log_errors_exceptions_as_warnings = FALSE;
>   
>   	if (!tables_failed) {
>   		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tables_loaded));
>   	} else {
> -		ACPI_ERROR((AE_INFO,
> +		ACPI_WARNING((AE_INFO,
>   			    "%u table load failures, %u successful",
>   			    tables_failed, tables_loaded));
>   
> diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
> index e3368186e1c1..fc3794c1c324 100644
> --- a/drivers/acpi/acpica/uterror.c
> +++ b/drivers/acpi/acpica/uterror.c
> @@ -205,7 +205,10 @@ acpi_ut_namespace_error(const char *module_name,
>   	char *name = NULL;
>   
>   	ACPI_MSG_REDIRECT_BEGIN;
> -	acpi_os_printf(ACPI_MSG_ERROR);
> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> +		acpi_os_printf(ACPI_MSG_WARNING);
> +	else
> +		acpi_os_printf(ACPI_MSG_ERROR);
>   
>   	if (lookup_status == AE_BAD_CHARACTER) {
>   
> @@ -269,7 +272,10 @@ acpi_ut_method_error(const char *module_name,
>   	struct acpi_namespace_node *node = prefix_node;
>   
>   	ACPI_MSG_REDIRECT_BEGIN;
> -	acpi_os_printf(ACPI_MSG_ERROR);
> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> +		acpi_os_printf(ACPI_MSG_WARNING);
> +	else
> +		acpi_os_printf(ACPI_MSG_ERROR);
>   
>   	if (path) {
>   		status = acpi_ns_get_node(prefix_node, path,
> diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
> index 950a1e500bfa..553b4eee8cec 100644
> --- a/drivers/acpi/acpica/utxferror.c
> +++ b/drivers/acpi/acpica/utxferror.c
> @@ -73,7 +73,10 @@ acpi_error(const char *module_name, u32 line_number, const char *format, ...)
>   	va_list arg_list;
>   
>   	ACPI_MSG_REDIRECT_BEGIN;
> -	acpi_os_printf(ACPI_MSG_ERROR);
> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> +		acpi_os_printf(ACPI_MSG_WARNING);
> +	else
> +		acpi_os_printf(ACPI_MSG_ERROR);
>   
>   	va_start(arg_list, format);
>   	acpi_os_vprintf(format, arg_list);
> @@ -107,16 +110,14 @@ acpi_exception(const char *module_name,
>   	va_list arg_list;
>   
>   	ACPI_MSG_REDIRECT_BEGIN;
> -
> -	/* For AE_OK, just print the message */
> -
> -	if (ACPI_SUCCESS(status)) {
> +	if (acpi_gbl_log_errors_exceptions_as_warnings)
> +		acpi_os_printf(ACPI_MSG_WARNING);
> +	else
>   		acpi_os_printf(ACPI_MSG_EXCEPTION);
>   
> -	} else {
> -		acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
> -			       acpi_format_exception(status));
> -	}
> +	/* For failures append the formatted exception */
> +	if (ACPI_FAILURE(status))
> +		acpi_os_printf("%s, ", acpi_format_exception(status));
>   
>   	va_start(arg_list, format);
>   	acpi_os_vprintf(format, arg_list);
> 
