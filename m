From: Wolfram Gloger <wmglo-icbQPRvlPmzsFLaNRtWx27DyIQmqzodN@public.gmane.org>
Subject: [repost w/ PATCH] Wrong initialization in mp_config_acpi_legacy_irqs()
Date: Mon, 23 Jun 2003 14:32:12 +0200 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306231232.OAA10526@max.zk-i.med.uni-muenchen.de>
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

Hi,

Please see:

http://sourceforge.net/mailarchive/message.php?msg_id=5248016

The problem still exists in acpi-20030619-2.4.21.diff.
This time I'm appending a patch, which applies on top of the
acpi patches.

Regards,
Wolfram.

--- arch/i386/kernel/mpparse.c~	Sun Jun 15 15:56:35 2003
+++ arch/i386/kernel/mpparse.c	Sun Jun 15 15:58:31 2003
@@ -516,7 +516,8 @@
 	mp_bus_id_to_local = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 2];
 	mp_bus_id_to_pci_bus = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 3];
 	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(max_mp_busses * sizeof(int)) * 4];
-	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses);
+	for (count=0; count<max_mp_busses; ++count)
+	  mp_bus_id_to_pci_bus[count] = -1;
 
 	/*
 	 *	Now process the configuration blocks.
@@ -1152,7 +1153,8 @@
 	mp_bus_id_to_local = (int *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 2];
 	mp_bus_id_to_pci_bus = (int *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 3];
 	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 4];
-	memset(mp_bus_id_to_pci_bus, -1, MAX_MP_BUSSES);
+	for (i=0; i<MAX_MP_BUSSES; ++i)
+	  mp_bus_id_to_pci_bus[i] = -1;
 
 	/* 
 	 * Fabricate the legacy ISA bus (bus #31).


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
