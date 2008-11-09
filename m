From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 5/5] ACPI: EC: lower interrupt storm treshold
Date: Sun, 09 Nov 2008 19:01:06 +0300
Message-ID: <20081109160105.13635.52054.stgit@thinkpad>
References: <20081109155847.13635.15244.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43611 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755279AbYKIQBI (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 11:01:08 -0500
In-Reply-To: <20081109155847.13635.15244.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Referencies: http://bugzilla.kernel.org/show_bug.cgi?id=11892
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9646604..628b076 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -70,7 +70,7 @@ enum ec_command {
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
 
-#define ACPI_EC_STORM_THRESHOLD 20	/* number of false interrupts
+#define ACPI_EC_STORM_THRESHOLD 8	/* number of false interrupts
 					   per one transaction */
 
 enum {

