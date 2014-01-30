From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI / proc: remove unneeded NULL check
Date: Thu, 30 Jan 2014 14:55:15 +0300
Message-ID: <20140130115515.GF12734@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We already verified that "ldev" was non-NULL earlier and also we
dereference again without checking a three lines later.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 50fe34ffe932..75c28eae8860 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -60,7 +60,7 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 				seq_printf(seq, "%c%-8s  %s:%s\n",
 					dev->wakeup.flags.run_wake ? '*' : ' ',
 					(device_may_wakeup(&dev->dev) ||
-					(ldev && device_may_wakeup(ldev))) ?
+					device_may_wakeup(ldev)) ?
 					"enabled" : "disabled",
 					ldev->bus ? ldev->bus->name :
 					"no-bus", dev_name(ldev));
