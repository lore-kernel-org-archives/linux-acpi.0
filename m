From: Ole Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Fujitsu Lifebook P2120 S3 sleep: progress report + patch
Date: 28 Feb 2003 14:40:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <ebw1y1swmjv.fsf@pcedu3.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

After a lot of stumbling in the dark, I'm able to get the P2120 to
wake up from S3 sleep with a working network. The LCD panel is still
black, so I'm open to suggestions...

With 2.5.63, the machine hangs in acpi_leave_sleep_state as it
tries to reenable BM arbitration. The reason seems to be the calling
order of
        acpi_system_save_state / acpi_enter_sleep_state_prep 
        acpi_leave_sleep_state / acpi_system_restore_state
on suspend and resume, respectively. 

What is the rationale behind the current practice of shutting down
devices *after* calling _PTS/_GTS, then resuming devices *before*
calling _BFS/_WAK? Intuitively, I'd expect the (lowlevel) ACPI methods
to be called at the innermost level, just surrounding the sleep state
- this is also what FreeBSD does. Anyway, reversing the call order I
got rid of the hang here.

I also had problems with going to sleep with the hardware lock,
clearly polling the WAKE_STATUS should be done without holding the
lock.

Finally, the 8139too driver clearly needs pci_set_power_state in order
to work after resume, is that the "trivial patch" someone else
mentioned earlier?

Ole

diff -Nru linux-2.5.63/drivers/acpi/sleep/main.c linux-2.5.63-local/drivers/acpi/sleep/main.c
--- linux-2.5.63/drivers/acpi/sleep/main.c	2003-02-15 00:51:06.000000000 +0100
+++ linux-2.5.63-local/drivers/acpi/sleep/main.c	2003-02-28 11:55:44.000000000 +0100
@@ -220,12 +220,12 @@
 		acpi_set_firmware_waking_vector((acpi_physical_address) acpi_wakeup_address);
 	}
 
-	acpi_enter_sleep_state_prep(state);
-
 	status = acpi_system_save_state(state);
 	if (!ACPI_SUCCESS(status))
 		return status;
 
+	acpi_enter_sleep_state_prep(state);
+
 	/* disable interrupts and flush caches */
 	ACPI_DISABLE_IRQS();
 	ACPI_FLUSH_CPU_CACHE();
@@ -237,8 +237,8 @@
 	 * mode. So, we run these unconditionaly to make sure we have a usable system
 	 * no matter what.
 	 */
-	acpi_system_restore_state(state);
 	acpi_leave_sleep_state(state);
+	acpi_system_restore_state(state);
 
 	/* make sure interrupts are enabled */
 	ACPI_ENABLE_IRQS();
diff -Nru linux-2.5.63/drivers/acpi/hardware/hwsleep.c linux-2.5.63-local/drivers/acpi/hardware/hwsleep.c
--- linux-2.5.63/drivers/acpi/hardware/hwsleep.c	2003-02-28 11:20:59.000000000 +0100
+++ linux-2.5.63-local/drivers/acpi/hardware/hwsleep.c	2003-02-28 11:56:48.000000000 +0100
@@ -318,7 +318,7 @@
 	/* Wait until we enter sleep state */
 
 	do {
-		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_DO_NOT_LOCK);
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}
diff -Nru linux-2.5.63/drivers/net/8139too.c linux-2.5.63-local/drivers/net/8139too.c
--- linux-2.5.63/drivers/net/8139too.c	2003-02-28 11:20:49.000000000 +0100
+++ linux-2.5.63-local/drivers/net/8139too.c	2003-02-28 12:07:43.000000000 +0100
@@ -565,6 +565,7 @@
 	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
+        u32 pci_state[16];
 	struct net_device_stats stats;
 	unsigned char *rx_ring;
 	unsigned int cur_rx;	/* Index into the Rx buffer of next Rx pkt. */
@@ -2562,6 +2563,9 @@
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_save_state (pdev, tp->pci_state);
+	pci_set_power_state (pdev, 3);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2570,10 +2574,14 @@
 static int rtl8139_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct rtl8139_private *tp = dev->priv;
 
 	if (!netif_running (dev))
 		return 0;
 	netif_device_attach (dev);
+	pci_set_power_state (pdev, 0);
+	pci_restore_state (pdev, tp->pci_state);
+	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	return 0;
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
