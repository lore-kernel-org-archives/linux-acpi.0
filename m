From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/2] ACPI / video: Quirk initial backlight level 0
Date: Wed, 06 Nov 2013 09:07:10 +0800
Message-ID: <5279963E.8030109@intel.com>
References: <52799553.7020406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39046 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373Ab3KFBG0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Nov 2013 20:06:26 -0500
In-Reply-To: <52799553.7020406@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Qingshuai Tian <qingshuai.tian@intel.com>, erno@iki.fi, Kirill Tkhai <tkhai@yandex.ru>, Shuduo Sang <sangshuduo@gmail.com>

Some firmware doesn't initialize initial backlight level to a proper
value and _BQC will return 0 on first time evaluation. We used to be
able to detect such incorrect value with our code logic, as value 0
normally isn't a valid value in _BCL. But with the introduction of Win8,
firmware begins to fill _BCL with values from 0 to 100, now 0 becomes
a valid value but that value will make user's screen black. This patch
test initial _BQC for value 0, if such a value is returned, do not use
it.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=64031
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=61231
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=63111
Reported-by: Qingshuai Tian <qingshuai.tian@intel.com>
Tested-by: Aaron Lu <aaron.lu@intel.com> on "Idealpad u330p"
Reported-and-tested-by: <erno@iki.fi> on "Acer Aspire V5-573G"
Reported-and-tested-by: Kirill Tkhai <tkhai@yandex.ru> on "HP 250 G1"
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/acpi/video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bf521b36c2f9..a049fa9360d0 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -858,7 +858,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		for (i = 2; i < br->count; i++)
 			if (level == br->levels[i])
 				break;
-		if (i == br->count)
+		if (i == br->count || !level)
 			level = max_level;
 	}
 
-- 
1.8.4.39.ga0d3f10
