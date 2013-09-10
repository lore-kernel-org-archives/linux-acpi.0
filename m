From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [RFC] MAINTAINERS: Update ACPI git tree
Date: Tue, 10 Sep 2013 16:35:01 +0300
Message-ID: <1378820101-28243-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5765 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab3IJNfS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Sep 2013 09:35:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Update ACPI git tree URL since recent ACPI updates are merged from
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
and since there hasn't been updates for a while in
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87efa1f..95f7f83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -241,7 +241,7 @@ M:	Rafael J. Wysocki <rjw@sisk.pl>
 L:	linux-acpi@vger.kernel.org
 W:	http://www.lesswatts.org/projects/acpi/
 Q:	http://patchwork.kernel.org/project/linux-acpi/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 S:	Supported
 F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
-- 
1.8.4.rc3

