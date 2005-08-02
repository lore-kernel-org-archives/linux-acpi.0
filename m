From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Accessing DSDT entries within a kernel device driver
Date: Tue, 02 Aug 2005 15:50:12 -0600
Message-ID: <1123019412.5110.52.camel@tdi>
References: <42EFC9AD.8060607@selhorst.net> <1123015115.5110.28.camel@tdi>
	 <42EFE697.8030701@selhorst.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42EFE697.8030701-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcel Selhorst <acpi-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-08-02 at 23:33 +0200, Marcel Selhorst wrote:

> > There's a driver for it in -mm, 
> 
> oh I know, I have written it ;-))

  Heh, I should pay better attention to who I'm talking to ;^)

> > but it uses hard coded address (blech) and doesn't work on my laptop.
> 
> Thats the point why I am trying to use the ACPI-functions in order to
> configure the TPM. Until now I assumed, that the ioports are correctly
> set into the configuration registers of the TPM through the BIOS (at
> least my prototypes did), but the feedback showed me, that it is not
> always the case. Currently I am revising the kernel source code to do this
> automatically and a new release will follow soon including support for
> Infineons new TPM 1.2 chips.

   Very cool.  While you're at it, I think we're going to end up having
TPMs that live in MMIO space instead of I/O port space.  I assume the
access semantics are pretty similar, readb/writeb vs inb/outb, but it's
probably a good time to add that too.

> 
> I was looking in the acpi-sourcecode trying to get the "acpi_evaluate_object"-
> things working, but wasn't succesful :(
> Nevertheless, could you give a hint how to extract the resources through ACPI?

   Completely untested, but based on 8250_pnp, I think you'd need
something like this:

static int __devinit tpm_inf_probe(struct pnp_dev *dev,
                                   const struct pnp_device_id *dev_id)
{
...
if (pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1)) {
	io_control = pnp_port_start(dev, 0)
	io_address = pnp_port_start(dev, 1)
} else if (pnp_mem_valid(dev, 0) && pnp_mem_valid(dev, 1)) {
	mem_control = pnp_mem_start(dev, 0)
	mem_address = pnp_mem_start(dev, 1)
}
...
}

static const struct pnp_device_id tpm_pnp_tbl[] = {
        /* Infineon TPM */
        {"IFX0101", 0},
        {"", 0}
};

MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);

static struct pnp_driver inf_pnp_driver = {
        .name = "tpm_inf_pnp",
        .id_table = tpm_pnp_tbl,
        .probe = tpm_inf_probe,
        .remove = __devexit_p(tpm_remove),
};

static int __init init_inf(void)
{
        return pnp_register_driver(&inf_pnp_driver);
}

static void __exit cleanup_inf(void)
{
        pnp_unregister_driver(&inf_pnp_driver);
}

If you want to use ACPI directly, have a look at 8250_acpi.  The PNP
stuff does seem easier since all of the complicated ACPI callback stuff
to fill in resources is handled for you.  I probably have some scrap
code around from when I was trying that approach if you'd like it.

> In the current release of IBMs generic tpm interface (tpm.c/h), the lpc-stuff has
> been replaced through pci_enable_device-calls exactly for this reason to make the
> interface more flexible and LPC-bus-independent. But enhancing it with
> ACPI-functionality would really be great.

   Cool, sounds like things are on the right track.  Let me know if I
can help further.  Thanks,
	
	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
