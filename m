From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v8 2/3] x86/tboot: Fail extended mode reduced
	hardware sleep
Date: Tue, 30 Jul 2013 08:24:53 -0400
Message-ID: <1375187094-19357-3-git-send-email-benjamin.guthro@citrix.com>
References: <1375187094-19357-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1375187094-19357-1-git-send-email-benjamin.guthro@citrix.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org
Cc: tboot-devel@lists.sourceforge.net, Ben Guthro <benjamin.guthro@citrix.com>
List-Id: linux-acpi@vger.kernel.org

Register for the extended sleep callback from acpi.
As tboot currently does not support the reduced hardware sleep
interface, fail this extended call.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Cc: tboot-devel@lists.sourceforge.net
Cc: Gang Wei <gang.wei@intel.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/tboot.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index addf7b5..ade00c8 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -301,6 +301,17 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 	return 0;
 }
 
+static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u32 val_b)
+{
+	if (!tboot_enabled())
+		return 0;
+
+	pr_warning("tboot is not able to suspend on platforms with"
+		   " reduced hardware sleep (ACPIv5). Please contact"
+		   " tboot-devel@lists.sourceforge.net mailing list.");
+	return -ENODEV;
+}
+
 static atomic_t ap_wfs_count;
 
 static int tboot_wait_for_aps(int num_aps)
@@ -422,6 +433,7 @@ static __init int tboot_late_init(void)
 #endif
 
 	acpi_os_set_prepare_sleep(&tboot_sleep);
+	acpi_os_set_prepare_extended_sleep(&tboot_extended_sleep);
 	return 0;
 }
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
