From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 06/10] ACPI: call acpi_debug_init() explicitly rather than  as initcall
Date: Wed, 25 Mar 2009 16:47:17 -0600
Message-ID: <200903251647.18535.bjorn.helgaas@hp.com>
References: <20090324224834.1262.65260.stgit@bob.kio> <200903250853.26374.bjorn.helgaas@hp.com> <49CA861D.1010502@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:46468 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZCYWrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2009 18:47:22 -0400
In-Reply-To: <49CA861D.1010502@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Zhao Yakui <yakui.zhao@intel.com>

On Wednesday 25 March 2009 01:29:33 pm Yinghai Lu wrote:
> Bjorn Helgaas wrote:
> > If I understand you correctly, you're raising a style issue, and
> > there's no functional problem either way.  Right?
> 
> besides that, some last_calls are merged to direct call.
> wonder if those calling could depend on pci_acpi_init etc.

Can you be specific?  I can't do much with vague wondering.

I changed the following initcalls from subsys_initcall to direct calls:

      ACPI: call acpi_scan_init() explicitly rather than as initcall
      ACPI: call acpi_ec_init() explicitly rather than as initcall
      ACPI: call acpi_power_init() explicitly rather than as initcall
      ACPI: call acpi_system_init() explicitly rather than as initcall
      ACPI: call acpi_debug_init() explicitly rather than as initcall

pci_acpi_init() is called from pci_subsys_init(), which is also a
subsys_initcall, but it's in arch/x86.

In the current tree (before my patches) all the ACPI subsys_initcalls
are done before any of the arch/x86 subsys_initcalls.  So changing the
ACPI subsys_initcalls to direct calls should not change the order with
respect to pci_acpi_init().

This one changed from an arch_initcall to a direct call:

      ACPI: call init_acpi_device_notify() explicitly rather than as initcall

In that case, init_acpi_device_notify() happens before pci_acpi_init()
whether it's an arch_initcall or a direct call.  So this shouldn't be
a problem either.

These two changed from late_initcalls to direct calls:

      ACPI: call acpi_sleep_proc_init() explicitly rather than as initcall
      ACPI: call acpi_wakeup_device_init() explicitly rather than as initcall

These two did change order with respect to pci_acpi_init().  As
late_initcalls, they happened after pci_acpi_init().  As direct calls,
they happen before pci_acpi_init().

However, I do not see any dependency of either one on pci_acpi_init(),
so I don't think it makes any difference.  Do you?

Bjorn
