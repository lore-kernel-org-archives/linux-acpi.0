From: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] acpi/osl: correct HZ dependencies
Date: Wed, 2 Mar 2005 11:48:21 -0800
Message-ID: <20050302194821.GG2741@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Kernel-Janitors <kernel-janitors-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

Please consider applying.

Description: The osl driver has a few dependencies on HZ which are not
handled correctly for all values. Use msleep_interruptible() and
jiffies_to_msecs() to rectify the situation. Patch is compile-tested.

--- 2.6.11-kj-v/drivers/acpi/osl.c	2005-03-01 23:38:38.000000000 -0800
+++ 2.6.11-kj/drivers/acpi/osl.c	2005-03-02 11:47:34.000000000 -0800
@@ -317,8 +317,7 @@ acpi_os_remove_interrupt_handler(u32 irq
 void
 acpi_os_sleep(acpi_integer ms)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(((signed long) ms * HZ) / 1000);
+	msleep_interruptible((unsigned int)ms);
 }
 EXPORT_SYMBOL(acpi_os_sleep);
 
@@ -938,7 +937,7 @@ acpi_os_wait_semaphore(
 		// TODO: A better timeout algorithm?
 		{
 			int i = 0;
-			static const int quantum_ms = 1000/HZ;
+			unsigned int quantum_ms = jiffies_to_msecs(1);
 
 			ret = down_trylock(sem);
 			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
