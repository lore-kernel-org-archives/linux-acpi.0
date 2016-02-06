From: green@linuxhacker.ru
Subject: [PATCH] acpi/ec: Deny write access unless requested by module param
Date: Sat,  6 Feb 2016 02:08:08 -0500
Message-ID: <1454742488-2231898-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>
List-Id: linux-acpi@vger.kernel.org

From: Oleg Drokin <green@linuxhacker.ru>

In debugfs it's not enough to just set file mode to read-only to
deny write access to a file, instead just don't provide
the write method unless write access is really requested.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
I assume allowing run-time changes via /sys/module is preferrable,
opposed to forced module unload and reload to change this option,
but I can submit another patch to only depend on the module parameter
too, please let me know.

 drivers/acpi/ec_sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index bea8e42..6c7dd7a 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -73,6 +73,9 @@ static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
 	loff_t init_off = *off;
 	int err = 0;
 
+	if (!write_support)
+		return -EINVAL;
+
 	if (*off >= EC_SPACE_SIZE)
 		return 0;
 	if (*off + count >= EC_SPACE_SIZE) {
-- 
2.1.0
