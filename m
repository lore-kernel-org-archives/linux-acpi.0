From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: pci device resume too early?
Date: Thu, 29 Jul 2004 08:48:26 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F036BD822@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

How about add one line in pci_default_resume just like this:

static void pci_default_resume(struct pci_dev *pci_dev)
{
+	pci_set_power_state(pci_dev, 0);
	/* restore the PCI config space */
	pci_restore_state(pci_dev, pci_dev->saved_config_space);
	/* if the device was enabled before suspend, reenable */


Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of stefandoesinger-RbZlAiThDcE@public.gmane.org
>Sent: Thursday, July 29, 2004 1:54 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] pci device resume too early?
>
>Hello,
>I have problems with a few pci devices after resume. Hardware
environment
>is a
>acer Travelmate 803(lspci attached), I use an unpatched linux-2.6.8-rc2
>kernel.
>
>The problem is that directly after S3 resume, any attempt to write to
pci
>configuration registers of three of my devices(00:1d.7, 00:1f.5,
00:1f.6)
>locks up my system. After some testing, I found out that
pci_restore_state
>works nice if I place it into a function which is scheduled with
>schedule_delayed_work. I use my dummydriver module for testing.
>
>Using mdelay(something) instead of scheduling a work doesn't help, so
it's
>not
>the hardware which needs some time.
>Is it possible that the driver's resume functions are called too early?
Can
>you point me to the place in the acpi code which calls the resume
methods
>that I can do further testing? I couldn't find it.
>
>Thanks in advance,
>Stefan


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
