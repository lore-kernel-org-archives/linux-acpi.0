From: minyard@acm.org
Subject: [PATCH] acpi:ipmi: Convert ipmi_user_t to
 struct ipmi_user *
Date: Wed, 18 Apr 2018 10:15:41 -0500
Message-ID: <1524064541-22252-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Lv Zheng <lv.zheng@intel.com>, Corey Minyard <cminyard@mvista.com>
List-Id: linux-acpi@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpi_ipmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

I'm getting rid of this annoying coding style violation, if you
could get this in that would be great.

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 1b64419..712fd31 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -46,7 +46,7 @@ struct acpi_ipmi_device {
 	spinlock_t tx_msg_lock;
 	acpi_handle handle;
 	struct device *dev;
-	ipmi_user_t user_interface;
+	struct ipmi_user *user_interface;
 	int ipmi_ifnum; /* IPMI interface number */
 	long curr_msgid;
 	bool dead;
@@ -125,7 +125,7 @@ ipmi_dev_alloc(int iface, struct device *dev, acpi_handle handle)
 {
 	struct acpi_ipmi_device *ipmi_device;
 	int err;
-	ipmi_user_t user;
+	struct ipmi_user *user;
 
 	ipmi_device = kzalloc(sizeof(*ipmi_device), GFP_KERNEL);
 	if (!ipmi_device)
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
