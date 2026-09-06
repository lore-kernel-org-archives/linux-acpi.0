Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7238DC56;
	Sun,  6 Sep 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710223; cv=none; b=Uq38d79MJBka9Kl+SkZYtpeDwbhHRW5bk4Bxtw1uJSryNDFMPKqWX9sFLAy4dMVXwlast+hcqnN16+v64YtGcwqUwjno91ePSw/PCU9LGVeGb6C7C88Fm2XyZKx5JRvd8XdgSAQni3cZTjA9K+SN4EnUHuUe0IRz4RFt4aB6Blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710223; c=relaxed/simple;
	bh=+sN1BOZgcqt5e1XuR+e2V8jDTezM2exro7ksi8BrY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HL2KqQEw+uHnZ+YcRmlElxOSAjnmEIEc7jIk6057+H/Mb6Engy/y5H+9ag0eXiRFcs+tSWYRVaBCmtP34P1HKQFLqDfV8ol5i+PLcsXuGyhYcahWr1EYIRnWYQvAkIFMWncwhLOpWgeAO4r1wXqZzMkotHNZUrDTBrmlBTA1084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJqm21oj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJqm21oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94551F00A3A;
	Sun,  6 Sep 2026 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710219;
	bh=9BuPP1J9hE67Bx0WxjFC0rAK/j6yeN+uS2eVtoGIYPs=;
	h=From:To:Cc:Subject:Date;
	b=hJqm21oj70iZGPxdVp27pIoHdzqKeSHUlEfY3O0ifeXNZ6daQQCD+vIxnbzkuayV3
	 yj3iiE1hX6OQ+LOqPGsrFq7wNmSFvKHL9ty8BGYpRI+nwkCqJNBFharC40w8ZYerrP
	 S6tfuXxsCYrESFD7ljSDNluko+tNx1VO8OqqaiKYCHmF3nHH7Ug+XYXcWf18U+jXip
	 1mpdFzSiMsFyLXZb4L0GFLtaTeIMFNQxhcIbahJ748v39RkSmHxFG7snwblrkBDwv/
	 /bkUtHp1VCaAHNKeIX2PYCNaBsze2TXdQWqtDBUrA/yc02l5TaZud8VhgFALYEFKWD
	 ridsvMWLRCdyA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1] ACPI: utils: Adjust message printing macros for ACPI objects
Date: Sun, 06 Sep 2026 17:56:56 +0200
Message-ID: <2300525.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The majority of acpi_handle_<level>() macros use neither pr_fmt() nor
dev_fmt() and acpi_handle_debug() uses pr_fmt() like dev_fmt(), but
only if dynamic debug is compiled in.

For more consistency, redefine all of the macros in question to use
dev_fmt() because they are more similar to the analogous dev_*()
family of macros than to the pr_*() ones and make all of them use it
in the same way.

While at it, rephrase the comment documenting those macros for more
clarity.

Fixes: 45fef5b88d1f ("ACPI: add dynamic_debug support")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/acpi.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1305,34 +1305,34 @@ void __acpi_handle_debug(struct _ddebug
 #endif
 
 /*
- * acpi_handle_<level>: Print message with ACPI prefix and object path
+ * acpi_handle_<level> - Print a message with ACPI prefix and object path
  *
- * These interfaces acquire the global namespace mutex to obtain an object
- * path.  In interrupt context, it shows the object path as <n/a>.
+ * In thread context, the global namespace mutex is acquired to obtain the
+ * object path.  In interrupt context, the object path is shown as <n/a>.
  */
 #define acpi_handle_emerg(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_EMERG, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_EMERG, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #define acpi_handle_alert(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_ALERT, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_ALERT, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #define acpi_handle_crit(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_CRIT, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_CRIT, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #define acpi_handle_err(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_ERR, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_ERR, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #define acpi_handle_warn(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_WARNING, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_WARNING, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #define acpi_handle_notice(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_NOTICE, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_NOTICE, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #define acpi_handle_info(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_INFO, handle, dev_fmt(fmt), ##__VA_ARGS__)
 
 #if defined(DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
-	acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__)
+	acpi_handle_printk(KERN_DEBUG, handle, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define acpi_handle_debug(handle, fmt, ...)				\
 	_dynamic_func_call(fmt, __acpi_handle_debug,			\
-			   handle, pr_fmt(fmt), ##__VA_ARGS__)
+			   handle, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #define acpi_handle_debug(handle, fmt, ...)				\
 ({									\



