From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2 v2] ACPI, extlog: remove unneeded NULL check
Date: Fri, 8 Nov 2013 00:24:49 -0800 (PST)
Message-ID: <20131108082449.GA19368@elgon.mountain>
References: <20131107072230.GA32127@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20131107072230.GA32127@gchen.bj.intel.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Chen, Gong" <gong.chen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Tony Luck <tony.luck@gmail.com>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We dereference extlog_l1_addr before checking if is NULL.  It turns out
"extlog_l1_addr" pointer can never be NULL when this function is called
so I have removed the check.

We can remove the "elog_addr" check as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: remove the elog_addr check as well.

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index a6869e1..17da458 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -310,10 +310,8 @@ static void __exit extlog_exit(void)
 {
 	mce_unregister_decode_chain(&extlog_mce_dec);
 	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
-		acpi_os_unmap_memory(extlog_l1_addr, l1_size);
-	if (elog_addr)
-		acpi_os_unmap_memory(elog_addr, elog_size);
+	acpi_os_unmap_memory(extlog_l1_addr, l1_size);
+	acpi_os_unmap_memory(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
 	release_mem_region(l1_dirbase, l1_size);
 	kfree(elog_buf);
