From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v6 4/5] x86/tboot: Fail extended mode reduced
	hardware sleep
Date: Mon, 1 Jul 2013 07:48:52 -0400
Message-ID: <1372679333-8473-5-git-send-email-benjamin.guthro@citrix.com>
References: <1372679333-8473-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1372679333-8473-1-git-send-email-benjamin.guthro@citrix.com>
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

As tboot currently does not support the reduced hardware sleep
interface, fail this extended call.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Cc: tboot-devel@lists.sourceforge.net
Cc: Gang Wei <gang.wei@intel.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/tboot.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index d578c9c..76c284f 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -285,6 +285,12 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
 	if (!tboot_enabled())
 		return 0;
 
+	if (extended)
+	if (WARN(extended,"tboot is not able to suspend on platforms with"
+	    " reduced hardware sleep (ACPIv5). Please contact"
+	    " tboot-devel@lists.sourceforge.net mailing list."))
+		return -1;
+
 	tboot_copy_fadt(&acpi_gbl_FADT);
 	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
 	tboot->acpi_sinfo.pm1b_cnt_val = pm1b_control;
-- 
1.7.9.5


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
