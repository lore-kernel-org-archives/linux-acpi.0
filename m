From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: device model?
Date: Thu, 12 Jun 2003 08:23:41 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0306120818510.11379-100000@cherise>
References: <20030612115641.GD30843@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030612115641.GD30843-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Why doesn't struct acpi_device contain a struct device?

Because they are not devices, only the firmware representation of them. :) 

> I was rather hoping that with the unified device model in 2.5 that I
> could finally model the innards of the zx1 boxes (ie SBA has a bunch of
> HBAs, each of which has a PCI root bus).  But it looks like acpi_device
> isn't part of the unified device model yet.  Is there a reason for this,
> other than lack of time?

struct acpi_device contains a kobject that is registered in 
drivers/acpi/scan.c. The hierarchy is represented in 
/sys/firmware/acpi/namespace.

Ideally, when an ACPI namespace object is found, the bus on which the 
device belongs will be notified of a found device, so that it may probe,
intiialize, and register the device properly. That will give it 
representation in /sys/devices, and ACPI could then provide a symlink 
between its object's directory and the device's directory. 

But, it hasn't happened yet.


	-pat



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
