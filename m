From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: ACPI on hp tc1100
Date: Sun, 5 Dec 2004 22:14:24 +0100
Message-ID: <200412052214.25733.stefandoesinger@gmx.at>
References: <41B2912D.8020105@joshuawise.com> <Pine.LNX.4.60.0412051210070.990@frog.athome> <41B377AE.7080108@joshuawise.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xo3sBgPCinvvsTa"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41B377AE.7080108-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, jamey.hicks-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_xo3sBgPCinvvsTa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Ah. In fact, when this system resumes from suspend, the wireless card
> refuses to work. Errors in dmesg:
> <system power on>
> ipw2100: eth0: ipw2100_verify failed: -5
> ipw2100: eth0: Failed to power on the adapter.
> ipw2100: eth0: Failed to start the firmware.
> Restarting tasks... done
> <I try to reload the driver>
> ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 1.0.1
> ipw2100: Copyright(c) 2003-2004 Intel Corporation
> ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 15 (level, low) -> IRQ 15
> ipw2100Device not found via register read.
>
> I will see if removing the driver before bringing the system down helps.
Try the attached patch(against the ipw2100 driver.

Stefan

--Boundary-00=_xo3sBgPCinvvsTa
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ipw2100-2.6.10-rc2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipw2100-2.6.10-rc2.patch"

--- ipw2100-1.0.0.orig/ipw2100.c	2004-11-11 22:48:55.000000000 +0800
+++ ipw2100-1.0.0/ipw2100.c	2004-11-21 11:07:56.000000000 +0800
@@ -6664,6 +6664,8 @@ static int ipw2100_suspend(struct pci_de
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
 	pci_save_state(pci_dev, priv->pm_state);
+#else
+	pci_save_state(pci_dev);
 #endif
 	pci_set_power_state(pci_dev, state);
 

--Boundary-00=_xo3sBgPCinvvsTa--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
