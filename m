From: root <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Patch: PCI device RESUME_POWER_ON handler
Date: 12 Mar 2003 17:33:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1y1c35pl.fsf@pcpenn04.cern.ch>
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

The appended patch allows pci-devices to register a handler for
RESUME_POWER_ON, to be called during S2/S3 resume *before* interrupts
are enabled. This is necessary eg to revive the Radeon M6 graphics
adapter on the Fujitsu P2120. (This is not all there is to getting the
P2120 video to work after resume...)

Now, how can I do the corresponding thing with the keyboard and mouse?
I don't see any pm related hooks in serio...

Ole

diff -Nru -X dontdiff linux-2.5.64/drivers/pci/pci-driver.c linux-p2120/drivers/pci/pci-driver.c
--- linux-2.5.64/drivers/pci/pci-driver.c	2003-03-05 04:29:31.000000000 +0100
+++ linux-p2120/drivers/pci/pci-driver.c	2003-03-07 10:29:07.000000000 +0100
@@ -91,11 +91,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 
 	if (pci_dev->driver) {
-		/* We may not call PCI drivers resume at
-		   RESUME_POWER_ON because interrupts are not yet
-		   working at that point. Calling resume at
-		   RESUME_RESTORE_STATE seems like solution. */
-		if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
+	        if (level == RESUME_POWER_ON && pci_dev->driver->power_on)
+			pci_dev->driver->power_on(pci_dev);
+		else if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
 			pci_dev->driver->resume(pci_dev);
 	}
 	return 0;
diff -Nru -X dontdiff linux-2.5.64/include/linux/pci.h linux-p2120/include/linux/pci.h
--- linux-2.5.64/include/linux/pci.h	2003-03-05 04:29:18.000000000 +0100
+++ linux-p2120/include/linux/pci.h	2003-03-07 10:29:07.000000000 +0100
@@ -499,6 +499,7 @@
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*power_on) (struct pci_dev *dev);	                /* Device power on */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
