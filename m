From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/6] ACPI / PM: Modify the "low-level resume finished" message
Date: Mon, 7 Feb 2011 23:19:55 +0100
Message-ID: <201102072319.56040.rjw@sisk.pl>
References: <201102072316.41270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201102072316.41270.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the low-level resume completion message to the point where
control goes back to acpi_suspend_enter() during resume and change
it so that it's more informative.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -263,6 +263,7 @@ static int acpi_suspend_enter(suspend_st
 
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel();
+		pr_info(PREFIX "Low-level resume complete\n");
 		break;
 	}
 
@@ -288,8 +289,6 @@ static int acpi_suspend_enter(suspend_st
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions_early();
 
-	printk(KERN_DEBUG "Back to C!\n");
-
 	suspend_nvs_restore();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
