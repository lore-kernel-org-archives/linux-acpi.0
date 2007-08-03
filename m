From: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/12] asus_acpi: fix possible double free (found by Coverity)
Date: Fri,  3 Aug 2007 18:33:40 -0400
Message-ID: <1186180432717-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763275AbXHCWdx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:53 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <de47b69c7b7be46b0848b2c4f8e23c478cd68690.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Len Brown <len.brown@intel.com>

From: Jesper Juhl <jesper.juhl@gmail.com>

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/asus_acpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 9c4bd22..86fd142 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1192,6 +1192,7 @@ static int asus_hotk_get_info(void)
 			break;
 		default:
 			kfree(model);
+			model = NULL;
 			break;
 		}
 	}
-- 
1.5.3.rc3.7.gd58e
