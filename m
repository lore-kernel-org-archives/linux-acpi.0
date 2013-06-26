From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v3 2/3] x86/tboot: Fail extended mode reduced hardware sleep
Date: Wed, 26 Jun 2013 10:06:14 -0400
Message-ID: <1372255575-29567-3-git-send-email-benjamin.guthro@citrix.com>
References: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, "Rafaell J . Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org
Cc: Ben Guthro <benjamin.guthro@citrix.com>, tboot-devel@lists.sourceforge.net, Gang Wei <gang.wei@intel.com>
List-Id: linux-acpi@vger.kernel.org

As tboot currently does not support the reduced hardware sleep
interface, fail this extended call.

Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: tboot-devel@lists.sourceforge.net
Cc: Gang Wei <gang.wei@intel.com>
---
 arch/x86/kernel/tboot.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f84fe00..016fbb8 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -273,7 +273,8 @@ static void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
 		offsetof(struct acpi_table_facs, firmware_waking_vector);
 }
 
-static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
+static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
+		       u8 extended)
 {
 	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] = {
 		/* S0,1,2: */ -1, -1, -1,
@@ -284,6 +285,9 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 	if (!tboot_enabled())
 		return 0;
 
+	if (extended)
+		return -1;
+
 	tboot_copy_fadt(&acpi_gbl_FADT);
 	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
 	tboot->acpi_sinfo.pm1b_cnt_val = pm1b_control;
-- 
1.7.9.5
