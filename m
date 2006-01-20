From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] drivers/acpi/hotkey.c: check kmalloc return value
Date: Fri, 20 Jan 2006 23:27:44 +0300
Message-ID: <20060120202744.GC8905@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.195]:4822 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932132AbWATUKW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 15:10:22 -0500
Received: by uproxy.gmail.com with SMTP id s2so53382uge
        for <linux-acpi@vger.kernel.org>; Fri, 20 Jan 2006 12:10:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Irwan Djajadi <irwan.djajadi@iname.com>, linux-acpi@vger.kernel.org

From: Irwan Djajadi <irwan.djajadi@iname.com>

Signed-off-by: Irwan Djajadi <irwan.djajadi@iname.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/acpi/hotkey.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -723,6 +723,8 @@ get_parms(char *config_record,
 		goto do_fail;
 	count = tmp1 - tmp;
 	*action_handle = (char *)kmalloc(count + 1, GFP_KERNEL);
+	if (!*action_handle)
+		goto do_fail;
 	strncpy(*action_handle, tmp, count);
 	*(*action_handle + count) = 0;
 

