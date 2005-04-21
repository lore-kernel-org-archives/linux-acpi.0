From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [ACPI] [RFC/PATCH 2/3] ACPI based I/O APIC hot-plug
Date: Thu, 21 Apr 2005 11:21:53 -0600
Message-ID: <1114104113.2784.41.camel@eeyore>
References: <4267AD1B.3040001@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <4267AD1B.3040001@jp.fujitsu.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Greg KH <greg@kroah.com>, acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> +acpi_status __devinit
>  acpi_map_iosapic (acpi_handle handle, u32 depth, void *context, void **ret)

I think "acpi_map_iosapic" is poorly named.  It's really associating
an iosapic with a locality domain.

And there's nothing ia64-specific in acpi_map_iosapic().  It'd be
nice to figure out a way to move it into generic ACPI code.

But your patch didn't introduce either of these problems, so
I don't think you have to fix them now.

>  	unsigned short 	num_rte;	/* number of RTE in this IOSAPIC */
> +	int		count;		/* # of RTEs in use on this IOSAPIC */

"count" isn't very descriptive.  Maybe "rtes_inuse" or similar? 

> -void __init
> +static inline int iosapic_alloc (void)

Nitpick: should be

	static inline int
	iosapic_alloc (void)

to match the style of the rest of the file.

> +static inline void free_iosapic (int index)

Nitpick: follow style again.

> +	memset(&iosapic_lists[index], 0, sizeof(struct iosapic));

What about

	memset(&iosapic_lists[index], 0, sizeof(iosapic_lists[0]));

so you can tell this is correct without looking up the declaration of
iosapic_lists[]?

> +static inline int iosapic_check (unsigned int gsi_base, unsigned int ver)

Nitpick: follow style again.  And maybe a more descriptive name?


