From: Corey Minyard <minyard@acm.org>
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
Date: Wed, 28 Feb 2007 15:42:11 -0600
Message-ID: <45E5F733.8080708@acm.org>
References: <200702102327.28312.lenb@kernel.org> <200702152103.54960.bjorn.helgaas@hp.com> <45D53DDE.5000300@acm.org> <200702192131.52947.bjorn.helgaas@hp.com> <45DA9931.80605@linux.intel.com> <45DAFDD8.909@acm.org> <20070225215922.GA28931@lists.us.dell.com> <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta15.mail.adelphia.net ([68.168.78.77]:36926 "EHLO
	mta15.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbXB1VmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Feb 2007 16:42:15 -0500
In-Reply-To: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan_Hargrave@Dell.com
Cc: Matt_Domsch@dell.com, alexey.y.starikovskiy@linux.intel.com, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org, bjorn.helgaas@hp.com

Jordan_Hargrave@Dell.com wrote:
> Corey,
>
>   Here is the patch (RHEL5 base code) I've been testing that detects the ACPI namespace object.
> The IPI0001 device doesn't contain the register spacing directly; it has a _CRS resource object that
> (for KCS) has two I/O port entries.  I save the first port in io.addr_data, then calculate the register spacing based on subtracting the 2nd port address and the 1st.
>   
This patch looks pretty good, comments inline below.
> I'm thinking of changing the register spacing to using an array of port/memory addresses to make calculating interface addresses more generic.
>   
Ok, I'll wait until you are sure here.  The changes below are fine, they
neaten things up a little.  It would probably need to be a separate patch.
> eg.
> static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
> {
>         unsigned int addr = io->addr_data;
>
>         return inb(addr + (offset * io->regspacing));
> }
>
> would become something like:
> static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
> {
>         unsigned int addr = io->addr_data[offset];
>
>         return inb(addr);
> }
>
> --jordan hargrave
> Dell Enterprise Linux Engineering
>
>
>   
> +
> +static struct acpi_driver acpi_ipmi_driver = {
> +  .name = ACPI_IPMI_DRIVER_NAME,
> +  .class = ACPI_IPMI_CLASS,
> +  .ids = ACPI_IPMI_HID,
> +  .ops = {
> +    .add = acpi_ipmi_add,
> +    .remove = acpi_ipmi_remove,
> +  },
> +};
>   
Need to fix the indention above.

Also, we need to delete the old code, I think.
> @@ -1576,6 +1694,12 @@ static __devinit void acpi_find_bmc(void
>  	if (acpi_failure)
>  		return;
>  
> +	/* Really we only need to get the IPMI device handle here */
> +	acpi_bus_register_driver(&acpi_ipmi_driver);
> +	acpi_bus_unregister_driver(&acpi_ipmi_driver);
>   
Again, I don't know ACPI, but the above code looks rather strange.

Thanks,

-Corey
