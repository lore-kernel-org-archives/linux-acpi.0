From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Wed, 17 Nov 2004 20:49:31 +0000
Message-ID: <20041117204931.GI1108@parcelfarce.linux.theplanet.co.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC087@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC087@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 17, 2004 at 10:27:58AM +0800, Yu, Luming wrote:
> 1.	-static unsigned int acpi_irq_irq;
> 	-static acpi_osd_handler acpi_irq_handler;
> 	-static void *acpi_irq_context;
> 
> 1.1  I don't think it is good idea to remove acpi_irq_irq, which just
> for FADT sci. If you haven't add FADT stuff in the dev_id_list.
> So , please consider add FADT GPE onto dev_id_list.

The FADT GPE blocks are handled separately, see
drivers/acpi/events/evsci.c and drivers/acpi/events/evgpeblk.c
However, they still call acpi_os_install_interrupt_handler() and
acpi_os_remove_interrupt_handler().

> 2.  	 +struct acpi_dev_id {
> 	+	acpi_osd_handler handler;
> 	+	void *context;
> 	+	int irq;
> 	+	struct acpi_dev_id *next;
> 	+};
> 
> 2.1  Do you think a spin lock or semaphore is unnecessary here?

I was wondering about that.  The question is whether two
processors can access dev_id_list at the same time.  Unfortunately, I
think it _is_ possible, so I'll send an updated patch to fix this issue.

> 3.  acpi_os_install_interrupt_handler
> 
> +	 * If this is the FADT interrupt, ignore the GSI from the core and
> +	 * use the value in our copy of the FADT instead.  It may not be the
> +	 * same if an interrupt source override exists for the SCI.
>  	 */
> -	gsi = acpi_fadt.sci_int;
> +	if (gsi == acpi_gbl_FADT->sci_int)
> +		gsi = acpi_fadt.sci_int;
> 
> 3.1  This part should be revised to handle gsi != acpi_gbl_FADT->sci_int case.
> Because ACPI spec said:" You must have an interrupt source override entry for 
> the IRQ mapped to the SCI interrupt if this IRQ is not identity mapped."
> GPE device need to look for their own override recorde.

This is something I don't understand very well.  Why is there an override?
Is this just for buggy BIOSes?  Why don't we override the acpi_gbl_FADT
sci_int?  Why do we have two copies of the FADT anyway?  Why does the core
use the pristine copy of the FADT when it might be wrong?  Why would we
need an override for GPE block interrupts?

> 4. acpi_os_remove_interrupt_handler
> 
> +	if (gsi == acpi_gbl_FADT->sci_int)
> +		gsi = acpi_fadt.sci_int;
> +
> +	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
> +		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
> +		       gsi);
> +		return AE_OK;
>  	}
> 
> 4.1 same reason as 3.1

Same questions as 3.1 ;-)

> 5. acpi_gpe_block_remove
> 
> 5.1 If you check code acpi_ev_delete_gpe_xrupt, you will find that
> if a GPE device's interrupt_level happen to equal to acpi_gbl_FADT->sci_int,
> the cleanup will abort.

But I don't call acpi_gpe_block_remove for FADT-mentioned GPE blocks.
Only new ones.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
