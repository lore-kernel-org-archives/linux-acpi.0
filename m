From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: tg3 ethernet not coming back properly after S3 suspend
	on Dell M70
Date: Fri, 10 Jun 2005 09:59:33 +0800
Message-ID: <1118368773.3860.3.camel@linux-hp.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575023E30BC@pdsmsx402.ccr.corp.intel.com>
	 <9540d0105060911066a4d4867@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9540d0105060911066a4d4867-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-06-09 at 11:06 -0700, Vladimir Vukicevic wrote:
> > >
> > >The root PCIE port on which the nvidia sits goes through similar
> > >lossage... no memory range behind the bridge is reported after resume,
> > >and MSI's are reported as disabled where they were enabled before.
> > >
> > >I haven't been able to track down if the tg3 resume function completes
> > >as of yet; it's hit and miss whether the display gets restored after a
> > >resume (dpms/vbetool sometimes help, sometimes they don't), and with
> > >the tg3 module loaded I can only send commands through in bursts...
> > >will give it another few tries.
> >
> > Not required testing tg3 driver now. If the bridge is broken, all
> > devices under it will be broken. Did you enable the PCIE port driver? I
> > suspect it's the cause, since default PCI resume routine can restore PCI
> > bridge's config space.
> 
> I did have CONFIG_PCIEBUSPORT enabled; disabling itseems to have made
> either had no change, or made matters worse.. I can't even get the
> system back to a usable state post-resume enough to save the output of
> some commands to a file.  (The screen is still refusing to come on,
> but usually even simple things like caps lock aren't working.  I
> haven't tracked down what variation causes the display to work after
> suspend;  none of the s3_suspend video modes help.)  One cycle the
> system seemed to come back to the same broken-tg3 state; hitting caps
> lock would toggle the LED, but only after a 3-5 second delay.
Please try below patch.

Long, is this patch ok to you? PCIE bridge itself requires to
save/restore config space.

Thanks,
Shaohua


--- a/drivers/pci/pcie/portdrv_pci.c	2005-06-08 10:36:05.000000000 +0800
+++ b/drivers/pci/pcie/portdrv_pci.c	2005-06-10 09:34:55.760496584 +0800
@@ -69,11 +69,16 @@ static void pcie_portdrv_remove (struct 
 #ifdef CONFIG_PM
 static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
 {
-	return pcie_port_device_suspend(dev, state);
+	int ret = pcie_port_device_suspend(dev, state);
+	pci_save_state(dev);
+	return ret;
 }
 
 static int pcie_portdrv_resume (struct pci_dev *dev)
 {
+	pci_restore_state(dev);
+	pci_enable_device(dev);
+	pci_set_master(dev);
 	return pcie_port_device_resume(dev);
 }
 #endif




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
