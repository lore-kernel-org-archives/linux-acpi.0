From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 problems with VIA EPIA MII-6000
Date: Fri, 14 May 2004 16:23:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040514142337.GA11685@elf.ucw.cz>
References: <33293.192.168.10.18.1083969343.squirrel@192.168.10.18>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <33293.192.168.10.18.1083969343.squirrel-Q0ErXNX1Rubd88mOHQKLlg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Tuschik <M.Tuschik-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> i'm trying to put my VIA EPIA MII-6000 into S3 sleep mode. After resume
> the OS is still working (this is good). Console is blank ant network
> doesn't work.
> 
> I started to discover the network problem. The driver "via-rhine" does not
> contain any suspend/resume code (to bad). I looked at other drivers and
> added some code here like:
> 
> static int via_rhine_suspend (struct pci_dev *pdev, u32 state)
> {
> 	struct net_device *dev = pci_get_drvdata(pdev);
> 	struct netdev_private *priv = netdev_priv(dev);
> 	pci_save_state(pdev, priv->pm_state);
> 	if (dev && netif_running (dev) && netif_device_present (dev)) {
> 		netif_device_detach (dev);
> 		via_rhine_close (dev);
> 	}
> 	return 0;
> }
> 
> static int via_rhine_resume (struct pci_dev *pdev)
> {
> 	struct net_device *dev = pci_get_drvdata(pdev);
> 	struct netdev_private *priv = netdev_priv(dev);
> 	pci_restore_state(pdev, priv->pm_state);
> 	if (dev && netif_running (dev) && !netif_device_present (dev)) {
> 		via_rhine_open (dev);
> 		netif_device_attach (dev);
> 		writew(readw(dev->base_addr + ChipCmd) | CmdRxOn | CmdRxDemand,
> dev->base_addr + ChipCmd);
> 	}
> 	return 0;
> }
> 
> 
> This does not work. I played arround a bit with no success so far. It
> seems that interrupts are not working after resume.
> 
> As i don't know what i'm doing here i ask if someone has an idea, what's
> going wrong here. Maybe some hints to get closer to a solution.

Try to rmmod via-rhine before suspend then reinsert it after resume.

								Pavel

-- 
When do you have heart between your knees?


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
