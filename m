From: Wolfram Gloger <wmglo-icbQPRvlPmzsFLaNRtWx27DyIQmqzodN@public.gmane.org>
Subject: Wrong initialization in acpi-20030523-2.4.21-rc3.diff [mp_config_acpi_legacy_irqs]
Date: Thu, 12 Jun 2003 14:32:25 +0200 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306121232.OAA97024@max.zk-i.med.uni-muenchen.de>
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
Cc: wmglo-icbQPRvlPmzsFLaNRtWx27DyIQmqzodN@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

While trying to merge acpi-20030523-2.4.21-rc3.diff into
kernel-source-2.4.20-2.4.20-8 (from Debian) I noticed the following
suspicious hunk from the acpi-22030523 patch:

(in mp_config_acpi_legacy_irqs)
+       mp_bus_id_to_pci_bus = (int *)&bus_data[(MAX_MP_BUSSES * sizeof(int)) * 
3];
+       mp_irqs = (struct mpc_config_intsrc *)&bus_data[(MAX_MP_BUSSES * sizeof(
int)) * 4];
+       memset(mp_bus_id_to_pci_bus, -1, MAX_MP_BUSSES);

Surely this needs to be:

       for (i=0; i<MAX_MP_BUSSES; ++i)
	   mp_bus_id_to_pci_bus[i] = -1;

instead of the memset().

Regards,
Wolfram.


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
