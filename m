From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 1/1] Added an additional Sony laptop to
 acpi_osi_dmi_table
Date: Thu, 15 Oct 2009 09:45:41 +0800
Message-ID: <037F493892196B458CD3E193E8EBAD4F01EDB41A43@pdsmsx502.ccr.corp.intel.com>
References: <1255568391-8400-1-git-send-email-timhoppen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27811 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528AbZJOBrh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2009 21:47:37 -0400
In-Reply-To: <1255568391-8400-1-git-send-email-timhoppen@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tim Hoppen <timhoppen@gmail.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "jgarzik@redhat.com" <jgarzik@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Is there any bug report for this issue?
If yes, can you add the link in the change log please?

Thanks,
Rui

-----Original Message-----
From: Tim Hoppen [mailto:timhoppen@gmail.com] 
Sent: Thursday, October 15, 2009 9:00 AM
Cc: lenb@kernel.org; Zhang, Rui; jgarzik@redhat.com; tj@kernel.org; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; Tim Hoppen
Subject: [PATCH 1/1] Added an additional Sony laptop to acpi_osi_dmi_table


Signed-off-by: Tim Hoppen <timhoppen@gmail.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e56b2a7..01cca5f 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -211,6 +211,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "Sony VGN-SR290J"),
 		},
 	},
+	{
+        .callback = dmi_disable_osi_vista,
+        .ident = "Sony VGN-FW351J",
+        .matches = {
+                     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+                     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW351J"),
+                },
+        },
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.6.5

