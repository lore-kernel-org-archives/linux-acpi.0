From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/37] suspend: fix ia64 allmodconfig build
Date: Thu, 31 Jan 2008 23:36:56 -0500
Message-ID: <fbfe034f5ef51cdd8338a868a2101608f8c45757.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:46275 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759118AbYBAEmC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:42:02 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

kernel/power/main.c:488: error: =E2=80=98pm_test_attr=E2=80=99 undeclar=
ed here (not in a function)

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5688168..050a607 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -53,10 +53,6 @@ int pm_notifier_call_chain(unsigned long val)
 			=3D=3D NOTIFY_BAD) ? -EINVAL : 0;
 }
=20
-#endif /* CONFIG_PM_SLEEP */
-
-#ifdef CONFIG_SUSPEND
-
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level =3D TEST_NONE;
=20
@@ -132,6 +128,7 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
=20
+#endif /* CONFIG_PM_SLEEP */
=20
 #ifdef CONFIG_SUSPEND
=20
@@ -495,7 +492,7 @@ static struct attribute * g[] =3D {
 #ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
 #endif
-#ifdef CONFIG_PM_DEBUG
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PM_DEBUG)
 	&pm_test_attr.attr,
 #endif
 	NULL,
--=20
1.5.4.rc5.16.gc0279

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
