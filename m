From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] drivers/acpi: Remove unnecessary cast
Date: Fri, 8 Jan 2010 11:12:41 -0700
Message-ID: <201001081112.41469.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753833Ab0AHSMr@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

drivers/acpi: Remove unnecessary cast.

The struct seq_file 'private' member is a void *, the cast is not needed.
Also, remove an extra whitespace line.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>

---

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 140c5c5..6deafb4 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -443,8 +443,7 @@ struct thermal_cooling_device_ops processor_cooling_ops = {
 #ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_limit_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
-
+	struct acpi_processor *pr = seq->private;
 
 	if (!pr)
 		goto end;
