From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] processor: jiffies-based bm_check
Date: 20 Jan 2005 23:08:06 -0500
Message-ID: <1106280485.2397.135.camel@d845pe>
References: <20041223140849.GE7973@dominikbrodowski.de>
	 <1103832683.4376.24.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SLUi2QT7iGI3vT+bTE0U"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1103832683.4376.24.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-SLUi2QT7iGI3vT+bTE0U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-12-23 at 15:11, Len Brown wrote:

> Didn't apply the jiffies part yet.

I've applied it now. (attached as jiffy.patch)

However, "threshold.bm = 0xF" was written when
HZ = 100 yielding 40ms, but this
becomes 4ms for HZ = 1000.

While I don't know what the optimal value is for
the bus master history threshold, it seemed like
a good idea for it to default to about 40ms per
the original code until we know better.

So I've also applied the attached bm_history.patch
to default this to 0xFFFFFFFF for HZ = 1000 (32ms)
and it is tunable via /sys/module/processor/parameters/bm_history

what do you think?

thanks,
-Len


--=-SLUi2QT7iGI3vT+bTE0U
Content-Disposition: inline; filename=bm_history.patch
Content-Type: text/plain; name=bm_history.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/20 22:43:52-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org 
#   [ACPI] Add a module parameter to allow tuning how much bus-master activity
#   we remember when entering C3 -- /sys/module/processor/parameters/bm_history
#   Default varies with HZ -- 40ms for 25 - 800 HZ, 32ms for 1000 HZ.
# 
# drivers/acpi/processor_idle.c
#   2005/01/20 22:43:44-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +11 -2
#   /sys/module/processor/parameters/bm_history
# 
diff -Nru a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c	2005-01-20 22:44:28 -05:00
+++ b/drivers/acpi/processor_idle.c	2005-01-20 22:44:28 -05:00
@@ -60,6 +60,15 @@
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
+/*
+ * bm_history -- bit-mask with a bit per jiffy of bus-master activity
+ * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
+ * 800 HZ: 0xFFFFFFFF: 32 jiffies = 40ms
+ * 100 HZ: 0x0000000F: 4 jiffies = 40ms
+ * reduce history for more aggressive entry into C3
+ */
+static unsigned int bm_history = (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
+module_param(bm_history, uint, 0644);
 /* --------------------------------------------------------------------------
                                 Power Management
    -------------------------------------------------------------------------- */
@@ -438,7 +447,7 @@
 			cx->demotion.threshold.ticks = cx->latency_ticks;
 			cx->demotion.threshold.count = 1;
 			if (cx->type == ACPI_STATE_C3)
-				cx->demotion.threshold.bm = 0x0F;
+				cx->demotion.threshold.bm = bm_history;
 		}
 
 		lower = cx;
@@ -458,7 +467,7 @@
 			else
 				cx->promotion.threshold.count = 10;
 			if (higher->type == ACPI_STATE_C3)
-				cx->promotion.threshold.bm = 0x0F;
+				cx->promotion.threshold.bm = bm_history;
 		}
 
 		higher = cx;

--=-SLUi2QT7iGI3vT+bTE0U
Content-Disposition: inline; filename=jiffy.patch
Content-Type: text/plain; name=jiffy.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/20 21:52:27-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org 
#   [ACPI] Make the bm_activity depend on "jiffies", instead of numbers
#   of the check being called. This means bus mastering activity
#   is assumed if bm_check isn't called; and multiple calls during
#   one jiffy will be |='ed.
#   
#   Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
#   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
# 
# include/acpi/processor.h
#   2005/01/20 21:52:11-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +1 -0
#   jiffies-based bus-master activity history
# 
# drivers/acpi/processor_idle.c
#   2005/01/20 21:52:11-05:00 len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org +14 -1
#   jiffies-based bus-master activity history
# 
diff -Nru a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c	2005-01-20 22:45:19 -05:00
+++ b/drivers/acpi/processor_idle.c	2005-01-20 22:45:19 -05:00
@@ -193,8 +193,18 @@
 	 */
 	if (pr->flags.bm_check) {
 		u32		bm_status = 0;
+		unsigned long	diff = jiffies - pr->power.bm_check_timestamp;
 
-		pr->power.bm_activity <<= 1;
+		if (diff > 32)
+			diff = 32;
+
+		while (diff) {
+			/* if we didn't get called, assume there was busmaster activity */
+			diff--;
+			if (diff)
+				pr->power.bm_activity |= 0x1;
+			pr->power.bm_activity <<= 1;
+		}
 
 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
 			&bm_status, ACPI_MTX_DO_NOT_LOCK);
@@ -213,6 +223,9 @@
 				|| (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
 				pr->power.bm_activity++;
 		}
+
+		pr->power.bm_check_timestamp = jiffies;
+
 		/*
 		 * Apply bus mastering demotion policy.  Automatically demote
 		 * to avoid a faulty transition.  Note that the processor
diff -Nru a/include/acpi/processor.h b/include/acpi/processor.h
--- a/include/acpi/processor.h	2005-01-20 22:45:19 -05:00
+++ b/include/acpi/processor.h	2005-01-20 22:45:19 -05:00
@@ -54,6 +54,7 @@
 
 struct acpi_processor_power {
 	struct acpi_processor_cx *state;
+	unsigned long		bm_check_timestamp;
 	u32			default_state;
 	u32			bm_activity;
 	int			count;

--=-SLUi2QT7iGI3vT+bTE0U--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
