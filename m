From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] acpi-video: Fix integer overflow and possible kernel stack trashing
Date: Sun, 19 Jul 2009 13:36:38 +0200
Message-ID: <200907191336.38261.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:58631 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbZGSLhO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Jul 2009 07:37:14 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

This patch fixes a possible kernel crash through stack trashing triggered
by an integer overflow. If count passed from userspace is (size_t)-1lu, the
range check will overflow and return false. So the copy_from_user() will
end up attempting to copy 0xFFFFFFFF (or 0xFFFFFFFFFFFFFFFF) bytes to the kernel stack.
Of course the copy will fail at some point, because we can't allocate a buffer that big.
But it will copy as much as it can and then return with an -EFAULT.
This means the userspace process writing to this proc file controls
the kernel stack.

This is probably not useable for a privilege escalation, because the proc file
has permissions (S_IFREG | S_IRUGO | S_IWUSR). So only root will be able to crash the machine.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Cc: stable@kernel.org

---

This patch is completely untested, because I do not have a machine with acpi-video.

---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1185,21 +1185,21 @@ acpi_video_device_write_state(struct fil
 			      const char __user * buffer,
 			      size_t count, loff_t * data)
 {
 	int status;
 	struct seq_file *m = file->private_data;
 	struct acpi_video_device *dev = m->private;
 	char str[12] = { 0 };
 	u32 state = 0;
 
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || count >= sizeof str)
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
 		return -EFAULT;
 
 	str[count] = 0;
 	state = simple_strtoul(str, NULL, 0);
 	state &= ((1ul << 31) | (1ul << 30) | (1ul << 0));
 
 	status = acpi_video_device_set_state(dev, state);

-- 
Greetings, Michael.
