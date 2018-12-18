From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v11 1/7] ACPI: Allow CONFIG_PCI to be unset for reboot
Date: Mon, 17 Dec 2018 23:31:39 -0800
Message-ID: <20181218073139.GA8612@infradead.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218025606.32668-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> +#ifdef CONFIG_PCI
> +		unsigned int devfn;
> +		struct pci_bus *bus0;
> +
>  		/* The reset register can only live on bus 0. */
>  		bus0 = pci_find_bus(0, 0);
>  		if (!bus0)
> @@ -44,8 +47,9 @@ void acpi_reboot(void)
>  		/* Write the value that resets us. */
>  		pci_bus_write_config_byte(bus0, devfn,
>  				(rr->address & 0xffff), reset_value);
> +#endif

This would be a lot cleaner if this was split into a little helper
function.
