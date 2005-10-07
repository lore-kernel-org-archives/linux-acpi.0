From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [Pcihpd-discuss] [patch 2/2] acpi: add ability to derive irq when doing a surprise removal of an adapter
Date: Fri, 7 Oct 2005 11:52:53 -0600
Message-ID: <20051007175253.GC22697@parisc-linux.org>
References: <1128707174.11020.12.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030329AbVJGRw6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1128707174.11020.12.camel@whizzy>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 07, 2005 at 10:46:14AM -0700, Kristen Accardi wrote:
> +void acpi_pci_irq_disable_nodev(struct pci_dev *dev)
> +{
[...]
> +
> +			acpi_unregister_gsi(gsi);
> +			return_VOID;
> +		}
> +	}
> +	return_VOID;

I really don't think you want 'return_VOID' here, unless you want to add
the ACPI_FUNCTION_TRACE() to the beginning of the function.
