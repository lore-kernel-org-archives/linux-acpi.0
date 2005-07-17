From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi/event.c: whitespace cleanups
Date: Sun, 17 Jul 2005 21:11:15 +0200
Message-ID: <20050717191114.GA12650@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This cleans up some whitespace in acpi/event.c. No code changes.

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -24,27 +24,23 @@ extern wait_queue_head_t	acpi_bus_event_
 static int
 acpi_system_open_event(struct inode *inode, struct file *file)
 {
-	spin_lock_irq (&acpi_system_event_lock);
+	spin_lock_irq(&acpi_system_event_lock);
 
-	if(event_is_open)
+	if (event_is_open)
 		goto out_busy;
 
 	event_is_open = 1;
 
-	spin_unlock_irq (&acpi_system_event_lock);
+	spin_unlock_irq(&acpi_system_event_lock);
 	return 0;
 
 out_busy:
-	spin_unlock_irq (&acpi_system_event_lock);
+	spin_unlock_irq(&acpi_system_event_lock);
 	return -EBUSY;
 }
 
 static ssize_t
-acpi_system_read_event (
-	struct file		*file,
-	char			__user *buffer,
-	size_t			count,
-	loff_t			*ppos)
+acpi_system_read_event(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	int			result = 0;
 	struct acpi_bus_event	event;
@@ -98,9 +94,7 @@ acpi_system_close_event(struct inode *in
 }
 
 static unsigned int
-acpi_system_poll_event(
-	struct file		*file,
-	poll_table		*wait)
+acpi_system_poll_event(struct file *file, poll_table *wait)
 {
 	poll_wait(file, &acpi_bus_event_queue, wait);
 	if (!list_empty(&acpi_bus_event_list))


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
