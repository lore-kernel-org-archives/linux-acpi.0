From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] acpi: Storage class should be before const qualifier
Date: Sun, 17 Feb 2008 15:38:43 +0100
Message-ID: <20080217143843.GA9249@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:35052 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbYBQO76 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Feb 2008 09:59:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org
Cc: trivial@kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the
beginning of the declaration specifiers in a declaration is an
obsolescent feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/acpi/ac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 76b9bea..43a95e5 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -63,7 +63,7 @@ static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device, int type);
 static int acpi_ac_resume(struct acpi_device *device);
 
-const static struct acpi_device_id ac_device_ids[] = {
+static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
 	{"", 0},
 };
-- 
1.5.4.1

