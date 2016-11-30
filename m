From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI / CPPC: set an error code on probe error path
Date: Wed, 30 Nov 2016 22:22:54 +0300
Message-ID: <20161130192254.GE28180@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We should return -EINVAL if get_cpu_device() fails.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d0d0504..e0ea8f5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -784,8 +784,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Add per logical CPU nodes for reading its feedback counters. */
 	cpu_dev = get_cpu_device(pr->id);
-	if (!cpu_dev)
+	if (!cpu_dev) {
+		ret = -EINVAL;
 		goto out_free;
+	}
 
 	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
