From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks v051205
Date: Tue, 6 Dec 2005 07:11:39 +0100
Message-ID: <20051206061139.GA691@isilmar.linta.de>
References: <200512051154.45500.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200512051154.45500.kernel-S9WDWIYMKk5AfugRpC6u6w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Con Kolivas <kernel-S9WDWIYMKk5AfugRpC6u6w@public.gmane.org>
Cc: linux list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ck list <ck-1Vlr8iRN5lTguvvKUr3tXg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, vatsa-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org, Daniel Petrini <d.pensator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Please merge this patch also into your dyntick patchset. Upon further
refleciton, we shouldn't be _this_ aggressive to enter C3-type sleep if
there was bus mastering activity this jiffy.

Signed-off-by: Dominik Brodowski	<linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -260,7 +260,7 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp = jiffies;
 
 		/*
-		 * If bus mastering is active, automatically demote
+		 * If bus mastering is or was active this jiffy, demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
 		 * function) but should upon the next.
@@ -271,7 +271,8 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (bm_status && cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x01) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			if (dyn_tick_enabled())


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
