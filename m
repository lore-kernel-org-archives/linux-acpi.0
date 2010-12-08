From: yakui.zhao@intel.com
Subject: [PATCH 2/3] IPMI: Add the document description
	of ipmi_get_smi_info
Date: Wed,  8 Dec 2010 10:10:17 +0800
Message-ID: <1291774218-6834-3-git-send-email-yakui.zhao@intel.com>
References: <1291774218-6834-1-git-send-email-yakui.zhao@intel.com>
	<1291774218-6834-2-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <1291774218-6834-2-git-send-email-yakui.zhao@intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: minyard@acm.org, lenb@kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Corey Minyard <cminyard@mvista.com>
List-Id: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Add the document description about how to use ipmi_get_smi_info.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 Documentation/IPMI.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/IPMI.txt b/Documentation/IPMI.txt
index 69dd29e..b2bea15 100644
--- a/Documentation/IPMI.txt
+++ b/Documentation/IPMI.txt
@@ -533,6 +533,33 @@ completion during sending a panic event.
 Other Pieces
 ------------
 
+Get the detailed info related with the IPMI device
+--------------------------------------------------
+
+Some users need more detailed information about a device, like where
+the address came from or the raw base device for the IPMI interface.
+You can use the IPMI smi_watcher to catch the IPMI interfaces as they
+come or go, and to grab the information, you can use the function
+ipmi_get_smi_info(), which returns the following structure:
+
+struct ipmi_smi_info {
+	enum ipmi_addr_src addr_src;
+	struct device *dev;
+	union {
+		struct {
+			void *acpi_handle;
+		} acpi_info;
+	} addr_info;
+};
+
+Currently special info for only for SI_ACPI address sources is
+returned.  Others may be added as necessary.
+
+Note that the dev pointer is included in the above structure, and
+assuming ipmi_smi_get_info returns success, you must call put_device
+on the dev pointer.
+
+
 Watchdog
 --------
 
-- 
1.5.4.5


------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
