From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux ACPI processor driver patch: user-definable power state
 limit
Date: 05 Nov 2004 17:58:19 -0500
Message-ID: <1099695499.13837.1618.camel@d845pe>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A193B6@hdsmsx401.amr.corp.intel.com>
	 <200410112335.19159.jos.delbar@ugent.be>
	 <1099683907.13837.1353.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1099683907.13837.1353.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jos Delbar <jos.delbar-Cru1EgDzd7c@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James P Ketrenos <james.p.ketrenos-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Please try out this acpi_cstate_limit patch.

This applies to 2.6.8.1, but in the likely event
that may mailer wraps this patch or you need 2.6.9, go here: 
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/cstate_limit/

thanks,
-Len

-----------
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/05 17:39:51-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org 
#   [ACPI] Allow limiting idle C-States.
#   
#   Useful to workaround C3 ipw2100 packet loss
#   and resonating noises heard on some laptops.
#   
#   For static processor driver, boot cmdline:
#   processor.acpi_cstate_limit=2
#   
#   For processor module, /etc/modprobe.conf:
#   options processor acpi_cstate_limit=2
#   
#   For manual processor module load:
#   # modprobe processor acpi_cstate_limit=2
#   
#   From kernel or kernel module:
#   #include <linux/acpi.h>
#   acpi_set_cstate_limit(2);
#   
#   Inspired by patches from Jos Delbar and Andi Kleen
#   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
# 
# include/linux/acpi.h
#   2004/11/05 17:39:45-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +26 -0
#   define API to set and get acpi_cstate_limit
# 
# drivers/acpi/processor.c
#   2004/11/05 17:39:45-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +10 -1
#   set and obey acpi_cstate_limit
# 
# drivers/acpi/osl.c
#   2004/11/05 17:39:45-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +9 -0
#   define acpi_cstate_limit
# 
diff -Nru a/drivers/acpi/osl.c b/drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	2004-11-05 17:40:07 -05:00
+++ b/drivers/acpi/osl.c	2004-11-05 17:40:07 -05:00
@@ -1078,3 +1078,12 @@
 
 __setup("acpi_leave_gpes_disabled", acpi_leave_gpes_disabled_setup);
 
+/*
+ * acpi_cstate_limit is defined in the base kernel so modules can
+ * change it w/o depending on the state of the processor module.
+ */
+unsigned int acpi_cstate_limit = ACPI_C_STATES_MAX;
+
+
+EXPORT_SYMBOL(acpi_cstate_limit);
+
diff -Nru a/drivers/acpi/processor.c b/drivers/acpi/processor.c
--- a/drivers/acpi/processor.c	2004-11-05 17:40:07 -05:00
+++ b/drivers/acpi/processor.c	2004-11-05 17:40:07 -05:00
@@ -459,8 +459,9 @@
 	 * Track the number of longs (time asleep is greater than threshold)
 	 * and promote when the count threshold is reached.  Note that bus
 	 * mastering activity may prevent promotions.
+	 * Do not promote above acpi_cstate_limit.
 	 */
-	if (cx->promotion.state) {
+	if (cx->promotion.state && (cx->promotion.state <= acpi_cstate_limit))
{
 		if (sleep_ticks > cx->promotion.threshold.ticks) {
 			cx->promotion.count++;
  			cx->demotion.count = 0;
@@ -498,6 +499,13 @@
 
 end:
 	/*
+	 * Demote if current state exceeds acpi_cstate_limit
+	 */
+	if (pr->power.state > acpi_cstate_limit) {
+		next_state = acpi_cstate_limit;
+	}
+
+	/*
 	 * New Cx State?
 	 * -------------
 	 * If we're going to start using a new Cx state we must clean up
@@ -2441,5 +2449,6 @@
 
 module_init(acpi_processor_init);
 module_exit(acpi_processor_exit);
+module_param_named(acpi_cstate_limit, acpi_cstate_limit, uint, 0);
 
 EXPORT_SYMBOL(acpi_processor_set_thermal_limit);
diff -Nru a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h	2004-11-05 17:40:07 -05:00
+++ b/include/linux/acpi.h	2004-11-05 17:40:07 -05:00
@@ -471,4 +471,30 @@
 
 #endif /*!CONFIG_ACPI_INTERPRETER*/
 
+#define	ACPI_CSTATE_LIMIT_DEFINED	/* for driver builds */
+#ifdef	CONFIG_ACPI
+
+/*
+ * Set highest legal C-state
+ * 0: C0 okay, but not C1
+ * 1: C1 okay, but not C2
+ * 2: C2 okay, but not C3 etc.
+ */
+
+extern unsigned int acpi_cstate_limit;
+
+static inline unsigned int acpi_get_cstate_limit(void)
+{
+	return acpi_cstate_limit;
+}
+static inline void acpi_set_cstate_limit(unsigned int new_limit)
+{
+	acpi_cstate_limit = new_limit;
+	return;
+}
+#else
+static inline unsigned int acpi_get_cstate_limit(void) { return 0; }
+static inline void acpi_set_cstate_limit(unsigned int new_limit) {
return; }
+#endif
+
 #endif /*_LINUX_ACPI_H*/





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
