From: Shawn Landden <shawn@churchofgit.com>
Subject: [PATCH] acpi: file missing include guard
Date: Fri, 13 Feb 2015 16:49:33 -0800
Message-ID: <1423874973-21135-1-git-send-email-shawn@churchofgit.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47388 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbbBNAtj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Feb 2015 19:49:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id bj1so22259254pad.5
        for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2015 16:49:39 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shawn Landden <shawn@churchofgit.com>

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 include/acpi/ghes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 720446c..4854f76 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -1,3 +1,5 @@
+#pragma once
+
 #include <acpi/apei.h>
 #include <acpi/hed.h>
 
-- 
2.2.1.209.g41e5f3a

