From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: device model?
Date: Thu, 12 Jun 2003 16:30:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030612153024.GJ30843@parcelfarce.linux.theplanet.co.uk>
References: <20030612115641.GD30843@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0306120818510.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306120818510.11379-100000-L1xM/EEGAB4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 12, 2003 at 08:23:41AM -0700, Patrick Mochel wrote:
> > Why doesn't struct acpi_device contain a struct device?
> 
> Because they are not devices, only the firmware representation of them. :) 

Umm.  OK, smartypants :-P

But I have some devices which _only_ have a firmware representation.
For example, there's a couple of serial ports on this workstation which
can't be found any other way.  Then there's the SBA and LBA devices I
mention below.  These devices have basically nothing in common except
that they only have an acpi_device to represent them.

> struct acpi_device contains a kobject that is registered in 
> drivers/acpi/scan.c. The hierarchy is represented in 
> /sys/firmware/acpi/namespace.
> 
> Ideally, when an ACPI namespace object is found, the bus on which the 
> device belongs will be notified of a found device, so that it may probe,
> intiialize, and register the device properly. That will give it 
> representation in /sys/devices, and ACPI could then provide a symlink 
> between its object's directory and the device's directory. 
> 
> But, it hasn't happened yet.

hmm.  so you want a serial_object, an lba_object and an sba_object?
then we can tie them together through the namespaces?  I feel lost in
a maze of pointers, all subtly different.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
