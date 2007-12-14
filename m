From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: + git-acpi-build-fix.patch added to -mm tree
Date: Fri, 14 Dec 2007 01:07:13 +0100
Message-ID: <200712140107.13630.rjw@sisk.pl>
References: <200712130343.lBD3hAmY011894@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36584 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbXLMXsG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 18:48:06 -0500
In-Reply-To: <200712130343.lBD3hAmY011894@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org, lenb@kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday, 13 of December 2007, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      git-acpi build fix
> has been added to the -mm tree.  Its filename is
>      git-acpi-build-fix.patch
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: git-acpi build fix
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> ia64 allmodconfig:
> 
> kernel/power/main.c:493: error: `pm_test_attr' undeclared here (not in a function)
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  kernel/power/main.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff -puN kernel/power/main.c~git-acpi-build-fix kernel/power/main.c
> --- a/kernel/power/main.c~git-acpi-build-fix
> +++ a/kernel/power/main.c
> @@ -489,9 +489,6 @@ static struct attribute * g[] = {
>  #ifdef CONFIG_PM_TRACE
>  	&pm_trace_attr.attr,
>  #endif
> -#ifdef CONFIG_PM_DEBUG
> -	&pm_test_attr.attr,
> -#endif

Doesn't it kill pm_test_attr on all architectures?

The proper (hopefully) fix is appended (Len, please add it to the suspend
branch).

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Fix compilation problems related to the /sys/power/pm_test attribute.
Namely, this attribute should also be available when
CONFIG_HIBERNATION is set and CONFIG_SUSPEND is unset and it should
not break compilation when neither of them is set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -50,10 +50,6 @@ int pm_notifier_call_chain(unsigned long
 			== NOTIFY_BAD) ? -EINVAL : 0;
 }
 
-#endif /* CONFIG_PM_SLEEP */
-
-#ifdef CONFIG_SUSPEND
-
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
@@ -127,6 +123,10 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
 
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_SUSPEND
+
 /* This is just an arbitrary number */
 #define FREE_PAGE_NUMBER (100)
 
@@ -484,7 +484,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
 #endif
-#ifdef CONFIG_PM_DEBUG
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PM_DEBUG)
 	&pm_test_attr.attr,
 #endif
 	NULL,
