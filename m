From: "David S. Miller" <davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: b44 suspend/resume (Re: PCI not restored correctly after
 suspend to ram)
Date: Mon, 22 Mar 2004 18:45:43 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040322184543.0c78a177.davem@redhat.com>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
	<1079728500.7277.140.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079728500.7277.140.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org, pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


How does this address the problem?  Only the restore is needed in
b44_resume, since we snapshot the PCI state after we init the
chip fully for the first time.

===== drivers/net/b44.c 1.15 vs edited =====
--- 1.15/drivers/net/b44.c	Sat Mar 13 22:54:58 2004
+++ edited/drivers/net/b44.c	Mon Mar 22 18:42:38 2004
@@ -1892,6 +1892,8 @@
 	if (!netif_running(dev))
 		return 0;
 
+	pci_restore_state(pdev, bp->pci_cfg_state);
+
 	spin_lock_irq(&bp->lock);
 
 	b44_init_rings(bp);


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
