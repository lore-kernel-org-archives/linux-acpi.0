From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 14:44:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020919144450.T10583@parcelfarce.linux.theplanet.co.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <1032428873.6326.5.camel@momo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1032428873.6326.5.camel-nTaTgD4n72I@public.gmane.org>; from fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org on Thu, Sep 19, 2002 at 11:47:53AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 19, 2002 at 11:47:53AM +0200, Federico Di Gregorio wrote:
> everything seems to work fine. how can i say if an interrupt has been
> wrongly assigned? anyway the only problem has always been there but i
> don't know if it is about irq:

So the problem exists in both the vanilla Marcelo kernel and in the
ACPI-patched kernel?  That doesn't seem like a reason to exclude the
ACPI patch from going in.

> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1f.03 not
> present in PCI namespace
> pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:1f.06 not
> present in PCI namespace

Interesting ... could you send the output from /sbin/lspci -s 00: I
suspect a bug in your machine's _PRT -- it's describing routing for a
device which doesn't exist.  Maybe we should silently ignore that.

> ACPI: Power Resource [PFAN] (off)
> 
> and later:
> 
> acpi_processor-2115 [07] acpi_processor_get_inf: Invalid PBLK length [5]

Interesting.  The code does:

        else if (object.processor.pblk_length < 6)
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
                        object.processor.pblk_length));
        else {
                pr->throttling.address = object.processor.pblk_address;
                pr->throttling.duty_offset = acpi_fadt.duty_offset;
                pr->throttling.duty_width = acpi_fadt.duty_width;
                pr->power.states[ACPI_STATE_C2].address =
                        object.processor.pblk_address + 4;
                pr->power.states[ACPI_STATE_C3].address =
                        object.processor.pblk_address + 5;
        }

so you're one element short, and that element is what tells us the address
to call to enter C3.  Clearly this is a broken BIOS, but I wonder if we
couldn't hande this more cleanly ...

	else if (object.processor.pblk_length < 4)
		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
			object.processor.pblk_length));
	else {
		pr->throttling.address = object.processor.pblk_address;
		pr->throttling.duty_offset = acpi_fadt.duty_offset;
		pr->throttling.duty_width = acpi_fadt.duty_width;
		if (object.processor.pblk_length >= 5)
			pr->power.states[ACPI_STATE_C2].address =
				object.processor.pblk_address + 4;
		if (object.processor.pblk_length >= 6)
			pr->power.states[ACPI_STATE_C3].address =
				object.processor.pblk_address + 5;
	}

Andy, what do you think?

-- 
Revolutions do not require corporate support.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
