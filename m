From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: b44 suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Mon, 22 Mar 2004 21:27:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403222127.43854.stefandoesinger@gmx.at>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079728500.7277.140.camel@dhcppc4>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/w0XA219ao2B4gW"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079728500.7277.140.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_/w0XA219ao2B4gW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
> > I can get most devices devies to work by setting the pci registers with
> > setpci after resume. I use the attached fixpci.sh script to do so. I can
> > get my soundcard, the ethernet card(02:02.0) ...
>
> 02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
> 01)
>
> I think this is the b44. Looking at b44_suspend/b44_resume, I don't see
> any calls to pci_save_state()/pci_restore_state() that I would expect,
> so it comes back after resume with bus mastering disabled etc.
I added pci_save_state()/pci_restore_state() to the b44 driver and it works.
I send the patch.
I don't know much about the diff utility so you might have to specify the 
files manually when patching.

> 02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
> 01)
>         Subsystem: Acer Incorporated [ALI]: Unknown device 001f
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at d0204000 (32-bit, non-prefetchable)
> [size=8K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 00: e4 14 01 44 06 01 10 08 01 00 00 02 00 40 00 00
> 10: 00 40 20 d0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
>
> ------------
> lspci_after_suspend
> 02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
> 01)
>         Subsystem: Acer Incorporated [ALI]: Unknown device 001f
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 5
>         Region 0: [virtual] Memory at d0204000 (32-bit,
> non-prefetchable) [disabled] [size=8K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 00: e4 14 01 44 00 00 10 00 01 00 00 02 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00

--Boundary-00=_/w0XA219ao2B4gW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b44.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44.h.diff"

--- linux-2.6.4-orig/drivers/net/b44.h	2004-02-18 04:58:36.000000000 +0100
+++ linux-2.6.4/drivers/net/b44.h	2004-03-22 21:06:01.000000000 +0100
@@ -538,6 +538,11 @@
 	u8			phy_addr;
 	u8			mdc_port;
 	u8			core_unit;
+	
+#ifdef CONFIG_PM
+	u32 pm_state[16];
+#endif
+	
 };
 
 #endif /* _B44_H */

--Boundary-00=_/w0XA219ao2B4gW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="b44.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b44.c.diff"

--- linux-2.6.4-orig/drivers/net/b44.c	2004-02-18 04:57:39.000000000 +0100
+++ linux-2.6.4/drivers/net/b44.c	2004-03-22 21:15:06.674051288 +0100
@@ -1863,6 +1863,8 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = dev->priv;
+	pci_save_state(pdev, bp->pm_state);
+
 
         if (!netif_running(dev))
                  return 0;
@@ -1877,6 +1879,9 @@
 	b44_free_rings(bp);
 
 	spin_unlock_irq(&bp->lock);
+	
+	pci_disable_device(pdev); /* disable busmastering */
+	pci_set_power_state(pdev,state); /* Zzz. */
 	return 0;
 }
 
@@ -1885,6 +1890,9 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = dev->priv;
 
+	pci_set_power_state(pdev,0);
+	pci_restore_state(pdev, bp->pm_state);
+		
 	if (!netif_running(dev))
 		return 0;
 
@@ -1899,6 +1907,7 @@
 	add_timer(&bp->timer);
 
 	b44_enable_ints(bp);
+
 	return 0;
 }
 

--Boundary-00=_/w0XA219ao2B4gW--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
