From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: acpi_irq_to_vector()
Date: Wed, 11 Jun 2003 19:27:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030611182726.GH28581@parcelfarce.linux.theplanet.co.uk>
References: <20030605192253.GS28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030605192253.GS28581-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 05, 2003 at 08:22:53PM +0100, Matthew Wilcox wrote:
> ok, we renamed gsi_to_vector to acpi_irq_to_vector(); that's fine.
> But we still have that ugly ifdef in there.  Any resistance to defining
> acpi_irq_to_vector to simply return its value on non-ia64 platforms?
> 
> Then it'd look like:
> 
> 	irq = acpi_fadt.sci_int;
> 	vector = acpi_irq_to_vector(irq);
> 	if (vector < 0) {
> 		printk(KERN_ERR PREFIX "SCI (IRQ%d) not registered\n", irq);
> 		return AE_OK;
> 	}
> 	acpi_irq_irq = vector;
> 	acpi_irq_handler = handler;
> 	acpi_irq_context = context;
> 	if (request_irq(vector, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {

Since nobody's arguing with me, I'm going to argue with myself ;-)

For PCI devices, we just read the irq out of the struct pci_dev.
The platform code gets the opportunity to mangle the irq in whatever
way it chooses before the pci_dev is passed to the driver.  Can we do
something similar for ACPI instead?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
