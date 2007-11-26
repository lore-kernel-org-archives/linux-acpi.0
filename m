From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] utilities/: Compliment va_start() with va_end().
Date: Mon, 26 Nov 2007 14:14:47 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A403BCB8FA@orsmsx415.amr.corp.intel.com>
References: <200711250205.34299.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44299 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbXKZWOt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2007 17:14:49 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200711250205.34299.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This is an interesting one to me.

>From various documentation:

After all arguments have been retrieved, va_end resets the pointer to
NULL.

va_end
Each invocation of va_start must be matched by a corresponding
invocation of va_end in the same function. After the call va_end(ap) the
variable ap is undefined. Multiple transversals of the list, each
bracketed by va_start and va_end are possible. va_end may be a macro or
a function.   

Now, I'm all for defensive programming, but I don't really see the point
of va_end when the list will be only traversed once.



We don't set all local pointers to NULL at function exit, what is the
point of doing it here?

I suppose some implementation could allocate memory at va_start, but in
practice, does this happen?

Bob


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Saturday, November 24, 2007 11:06 PM
>To: Moore, Robert
>Subject: Fwd: [PATCH] [ACPI] utilities/: Compliment va_start() with
>va_end().
>
>
>
>----------  Forwarded Message  ----------
>
>Subject: [PATCH] [ACPI] utilities/: Compliment va_start() with
va_end().
>Date: Saturday 24 November 2007 15:43
>From: Richard Knutsson <ricknu-0@student.ltu.se>
>To: len.brown@intel.com
>Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Richard
>Knutsson <ricknu-0@student.ltu.se>
>
>Compliment va_start() with va_end().
>
>Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
>---
>Compile-tested on i386 with allyesconfig & allmodconfig.
>
> utdebug.c |    2 ++
> utmisc.c  |    4 ++++
> 2 files changed, 6 insertions(+)
>
>
>diff --git a/drivers/acpi/utilities/utdebug.c
>b/drivers/acpi/utilities/utdebug.c
>index c7e128e..f45e3d5 100644
>--- a/drivers/acpi/utilities/utdebug.c
>+++ b/drivers/acpi/utilities/utdebug.c
>@@ -203,6 +203,7 @@ acpi_ut_debug_print(u32 requested_debug_level,
>
> 	va_start(args, format);
> 	acpi_os_vprintf(format, args);
>+	va_end(args);
> }
>
> ACPI_EXPORT_SYMBOL(acpi_ut_debug_print)
>@@ -240,6 +241,7 @@ acpi_ut_debug_print_raw(u32 requested_debug_level,
>
> 	va_start(args, format);
> 	acpi_os_vprintf(format, args);
>+	va_end(args);
> }
>
> ACPI_EXPORT_SYMBOL(acpi_ut_debug_print_raw)
>diff --git a/drivers/acpi/utilities/utmisc.c
>b/drivers/acpi/utilities/utmisc.c
>index 2d19f71..ca4904c 100644
>--- a/drivers/acpi/utilities/utmisc.c
>+++ b/drivers/acpi/utilities/utmisc.c
>@@ -1032,6 +1032,7 @@ acpi_ut_error(char *module_name, u32 line_number,
>char *format, ...)
>
> 	va_start(args, format);
> 	acpi_os_vprintf(format, args);
>+	va_end(args);
> 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
> }
>
>@@ -1046,6 +1047,7 @@ acpi_ut_exception(char *module_name,
>
> 	va_start(args, format);
> 	acpi_os_vprintf(format, args);
>+	va_end(args);
> 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
> }
>
>@@ -1060,6 +1062,7 @@ acpi_ut_warning(char *module_name, u32
line_number,
>char *format, ...)
>
> 	va_start(args, format);
> 	acpi_os_vprintf(format, args);
>+	va_end(args);
> 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
> }
>
>@@ -1076,5 +1079,6 @@ acpi_ut_info(char *module_name, u32 line_number,
char
>*format, ...)
>
> 	va_start(args, format);
> 	acpi_os_vprintf(format, args);
>+	va_end(args);
> 	acpi_os_printf("\n");
> }
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>-------------------------------------------------------
