From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 resume broken in 2.6.7
Date: Mon, 21 Jun 2004 15:39:48 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406211539.48269.stefandoesinger@gmx.at>
References: <GMail.1087700004.208457790.35614235518@brewt.org>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EFw1ApMloLJnKXT"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <GMail.1087700004.208457790.35614235518-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Adrian Yee <brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_EFw1ApMloLJnKXT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Sonntag, 20. Juni 2004 02:53 schrieb Adrian Yee:
> Hi,
>
> I've had S3 resume working with 2.6.5/6 (various mm and stock) and
> 2.6.7-rc3-mm1, but after trying 2.6.7-rc3-mm2 and 2.6.7 kernels, S3 resume
> has stopped working.  I'd rather not go through the process of modularizing
> all the drivers and figuring out what's causing the problem, so I wanted to
> know if anyone knows what change could have caused the problem.  Thanks.
>
On my notebook(Acer travelmate 803) I had the same problem. A look at the 
changelog showed me, that from 2.6.7-rc2 a default resume function restores 
the pci configuration of cards without a driver. On my system, any write to 
the soundcard's pci configuration done by a kernel driver after resume causes 
a crash.

I attached a path which undoes the change described above and should make S3 
work again.

Stefan

--Boundary-00=_EFw1ApMloLJnKXT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.7-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-fix"

--- linux-2.6.6/drivers/pci/pci-driver.c	2004-06-21 15:36:37.258692976 +0000
+++ drivers/pci/pci-driver.c	2004-06-16 21:16:14.000000000 +0000
@@ -332,8 +332,8 @@
 
 	if (drv && drv->resume)
 		drv->resume(pci_dev);
-	else
-		pci_default_resume(pci_dev);
+	//else
+	//	pci_default_resume(pci_dev);
 	return 0;
 }
 

--Boundary-00=_EFw1ApMloLJnKXT--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
