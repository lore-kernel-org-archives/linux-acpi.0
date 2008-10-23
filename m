From: Len Brown <lenb@kernel.org>
Subject: [PATCH 119/122] intel_menlo: fix build warning
Date: Thu, 23 Oct 2008 02:39:33 -0400
Message-ID: <eb83f493ab9f8bd09fb7a99ae6ae565e92470491.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbYJWGoH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:06 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

drivers/misc/intel_menlow.c:107: warning: format =E2=80=98%ld=E2=80=99 =
expects type =E2=80=98long int=E2=80=99, but argument 3 has type =E2=80=
=98long long unsigned int=E2=80=99

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/intel_menlow.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
index a782743..e00a275 100644
--- a/drivers/misc/intel_menlow.c
+++ b/drivers/misc/intel_menlow.c
@@ -104,7 +104,7 @@ static int memory_get_cur_bandwidth(struct thermal_=
cooling_device *cdev,
 	if (ACPI_FAILURE(status))
 		return -EFAULT;
=20
-	return sprintf(buf, "%ld\n", value);
+	return sprintf(buf, "%llu\n", value);
 }
=20
 static int memory_set_cur_bandwidth(struct thermal_cooling_device *cde=
v,
--=20
1.5.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
