From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 7/7] acer-wmi: Remove version number
Date: Sat, 21 Jun 2008 09:09:58 +0100
Message-ID: <20080621080958.26920.12607.stgit@pacifica>
References: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38509 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755140AbYFUIgJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 04:36:09 -0400
In-Reply-To: <20080621080903.26920.14225.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

It doesn't make much sense these days.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index d8b8574..e7a3fe5 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -22,8 +22,6 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define ACER_WMI_VERSION	"0.1"
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1177,8 +1175,7 @@ static int __init acer_wmi_init(void)
 {
 	int err;
 
-	printk(ACER_INFO "Acer Laptop ACPI-WMI Extras version %s\n",
-			ACER_WMI_VERSION);
+	printk(ACER_INFO "Acer Laptop ACPI-WMI Extras\n");
 
 	find_quirks();
 

