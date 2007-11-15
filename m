From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 13/15] ACPI: thinkpad-acpi: add suspend
	handler
Date: Thu, 15 Nov 2007 01:37:00 -0200
Message-ID: <1195097822-24738-14-git-send-email-hmh@hmh.eng.br>
References: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1195097822-24738-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a handler for suspend events.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b650dee..e799a74 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -188,6 +188,7 @@ struct ibm_struct {
 	int (*write) (char *);
 	void (*exit) (void);
 	void (*resume) (void);
+	void (*suspend) (pm_message_t state);
 
 	struct list_head all_drivers;
 
@@ -658,6 +659,21 @@ static struct input_dev *tpacpi_inputdev;
 static struct mutex tpacpi_inputdev_send_mutex;
 static LIST_HEAD(tpacpi_all_drivers);
 
+static int tpacpi_suspend_handler(struct platform_device *pdev,
+                                  pm_message_t state)
+{
+	struct ibm_struct *ibm, *itmp;
+
+	list_for_each_entry_safe(ibm, itmp,
+				 &tpacpi_all_drivers,
+				 all_drivers) {
+		if (ibm->suspend)
+			(ibm->suspend)(state);
+	}
+
+	return 0;
+}
+
 static int tpacpi_resume_handler(struct platform_device *pdev)
 {
 	struct ibm_struct *ibm, *itmp;
@@ -677,6 +693,7 @@ static struct platform_driver tpacpi_pdriver = {
 		.name = TPACPI_DRVR_NAME,
 		.owner = THIS_MODULE,
 	},
+	.suspend = tpacpi_suspend_handler,
 	.resume = tpacpi_resume_handler,
 };
 
-- 
1.5.3.4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
