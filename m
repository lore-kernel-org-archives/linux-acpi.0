From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works, does ACPI magic
Date: Mon, 21 May 2007 11:34:36 -0600
Message-ID: <200705211134.36578.bjorn.helgaas@hp.com>
References: <200705091222.29561.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:33492 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107AbXEURea (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 13:34:30 -0400
In-Reply-To: <200705091222.29561.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Wednesday 09 May 2007 01:22:29 pm David Brownell wrote:
>  static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
> ...
> +	switch (state) {
> +	case PCI_D0:
> +	case PCI_D1:
> +	case PCI_D2:
> +	case PCI_D3hot:
> +	case PCI_D3cold:
> +		return acpi_bus_set_power(handle, state_conv[state]);
> +	}
> +
> +	return -EINVAL;
>  }

Did you account for the fact that PCI works on a per-function basis,
but ACPI power management works on a per-slot basis?

We had a bug[1] a while back where e1000 would suspend a device and
call pci_power_state(), which used ACPI to turn off the slot.  The
only problem was that this was a dual-port card and the other port
was still active when the lights went out.

Maybe you deal with this already; it just wasn't obvious to me from
a quick glance through your patch.

Bjorn


[1] https://bugzilla.novell.com/show_bug.cgi?id=162320
