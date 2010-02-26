From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 6/6] thinkpad-acpi: lock down video output
	state access
Date: Fri, 26 Feb 2010 01:11:24 -0300
Message-ID: <1267157484-23925-7-git-send-email-hmh@hmh.eng.br>
References: <1267157484-23925-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1267157484-23925-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Given the right combination of ThinkPad and X.org, just reading the
video output control state is enough to hard-crash X.org.

Until the day I somehow find out a model or BIOS cut date to not
provide this feature to ThinkPads that can do video switching through
X RandR, change permissions so that only processes with CAP_SYS_ADMIN
can access any sort of video output control state.

This bug could be considered a local DoS I suppose, as it allows any
non-privledged local user to cause some versions of X.org to
hard-crash some ThinkPads.

Reported-by: Jidanni <jidanni-8D0D3YcSAvhAfugRpC6u6w@public.gmane.org>
Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 Documentation/laptops/thinkpad-acpi.txt |    4 ++++
 drivers/platform/x86/Kconfig            |   10 ++++++++--
 drivers/platform/x86/thinkpad_acpi.c    |   15 +++++++++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 75afa12..39c0a09 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -650,6 +650,10 @@ LCD, CRT or DVI (if available). The following commands are available:
 	echo expand_toggle > /proc/acpi/ibm/video
 	echo video_switch > /proc/acpi/ibm/video
 
+NOTE: Access to this feature is restricted to processes owning the
+CAP_SYS_ADMIN capability for safety reasons, as it can interact badly
+enough with some versions of X.org to crash it.
+
 Each video output device can be enabled or disabled individually.
 Reading /proc/acpi/ibm/video shows the status of each device.
 
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f526e73..11fce79 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -319,9 +319,15 @@ config THINKPAD_ACPI_VIDEO
 	  server running, phase of the moon, and the current mood of
 	  Schroedinger's cat.  If you can use X.org's RandR to control
 	  your ThinkPad's video output ports instead of this feature,
-	  don't think twice: do it and say N here to save some memory.
+	  don't think twice: do it and say N here to save memory and avoid
+	  bad interactions with X.org.
 
-	  If you are not sure, say Y here.
+	  NOTE: access to this feature is limited to processes with the
+	  CAP_SYS_ADMIN capability, to avoid local DoS issues in platforms
+	  where it interacts badly with X.org.
+
+	  If you are not sure, say Y here but do try to check if you could
+	  be using X.org RandR instead.
 
 config THINKPAD_ACPI_HOTKEY_POLL
 	bool "Support NVRAM polling for hot keys"
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3af4628..5d02cc0 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -286,6 +286,7 @@ struct ibm_init_struct {
 	char param[32];
 
 	int (*init) (struct ibm_init_struct *);
+	mode_t base_procfs_mode;
 	struct ibm_struct *data;
 };
 
@@ -4629,6 +4630,10 @@ static int video_read(struct seq_file *m)
 		return 0;
 	}
 
+	/* Even reads can crash X.org, so... */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	status = video_outputsw_get();
 	if (status < 0)
 		return status;
@@ -4662,6 +4667,10 @@ static int video_write(char *buf)
 	if (video_supported == TPACPI_VIDEO_NONE)
 		return -ENODEV;
 
+	/* Even reads can crash X.org, let alone writes... */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	enable = 0;
 	disable = 0;
 
@@ -8487,9 +8496,10 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 		"%s installed\n", ibm->name);
 
 	if (ibm->read) {
-		mode_t mode;
+		mode_t mode = iibm->base_procfs_mode;
 
-		mode = S_IRUGO;
+		if (!mode)
+			mode = S_IRUGO;
 		if (ibm->write)
 			mode |= S_IWUSR;
 		entry = proc_create_data(ibm->name, mode, proc_dir,
@@ -8680,6 +8690,7 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 #ifdef CONFIG_THINKPAD_ACPI_VIDEO
 	{
 		.init = video_init,
+		.base_procfs_mode = S_IRUSR,
 		.data = &video_driver_data,
 	},
 #endif
-- 
1.6.5.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
