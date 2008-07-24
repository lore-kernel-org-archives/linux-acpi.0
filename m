From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: git-acpi in linux-next
Date: Thu, 24 Jul 2008 14:01:36 +1000
Message-ID: <20080724140136.cc3fb2e5.sfr@canb.auug.org.au>
References: <20080723134643.dbf1e1a1.akpm@linux-foundation.org>
	<20080724101217.56f7f8f5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:54939 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbYGXEBm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jul 2008 00:01:42 -0400
In-Reply-To: <20080724101217.56f7f8f5.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi all,

On Thu, 24 Jul 2008 10:12:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I will try Len's tree again today (though the last update there is June
> 28 so I am not hopeful).

I merged Len's tree and fixed all the conflicts and the final diff from
before to after the merge is below.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 94a6efe..fcf0fb9 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -114,6 +114,8 @@ acpi_install_fixed_event_handler(u32 event,
 
 	ACPI_FUNCTION_TRACE(acpi_install_fixed_event_handler);
 
+	WARN_ON(acpi_disabled);
+
 	/* Parameter validation */
 
 	if (event > ACPI_EVENT_MAX) {
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index 38be586..8e5983f 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -390,6 +390,8 @@ acpi_walk_namespace(acpi_object_type type,
 
 	ACPI_FUNCTION_TRACE(acpi_walk_namespace);
 
+	WARN_ON(acpi_disabled);
+
 	/* Parameter validation */
 
 	if ((type > ACPI_TYPE_LOCAL_MAX) || (!max_depth) || (!user_function)) {
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index f34be67..169c788 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -1024,6 +1024,7 @@ acpi_ut_error(const char *module_name, u32 line_number, const char *format, ...)
 {
 	va_list args;
 
+	warn_on_slowpath(module_name, line_number);
 	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
 
 	va_start(args, format);
@@ -1038,6 +1039,7 @@ acpi_ut_exception(const char *module_name,
 {
 	va_list args;
 
+	warn_on_slowpath(module_name, line_number);
 	acpi_os_printf("ACPI Exception (%s-%04d): %s, ", module_name,
 		       line_number, acpi_format_exception(status));
 
