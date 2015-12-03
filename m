From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pci: completely disable aspm if it's unsupported
Date: Thu, 3 Dec 2015 23:40:13 +0100
Message-ID: <20151203224013.GG14427@amd>
References: <1447856703-2566-1-git-send-email-jbacik@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38099 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbLCWkQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 17:40:16 -0500
Content-Disposition: inline
In-Reply-To: <1447856703-2566-1-git-send-email-jbacik@fb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, bhelgaas@google.com, shli@fb.com, kernel-team@fb.com

Hi!

> We have some hardware that takes about 30 seconds to setup common clocks for
> ASPM, but our bios'es don't actually allow ASPM.  It seems we had this thing in
> place where we would disable ASPM after the pci bus probe so that we would make
> sure that pre pcie 1.1 devices would be properly skipped during initialization.
> This is because the mechanism to disable ASPM doesn't actually disable the
> setting up of the link state stuff, it just keeps us from changing the link
> state after the fact.  So instead make it so that when we call pcie_no_aspm()
> that we disable ASPM completley, that is we skip setting up the link state and
> everything.  This way we avoid the costly setup for a feature we cannot support
> in the first place and we also make sure we are safe from future tampering with
> the ASPM link state.  Thanks,

On thinkpad x60, I have similar problem.

I'm carying this for long long time now:

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a32ba75..5eb7621 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -700,7 +700,7 @@ static int __init acpi_pci_init(void)
 
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 		pr_info("ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
-		pcie_no_aspm();
+//		pcie_no_aspm();
 	}
 
 	ret = register_acpi_bus_type(&acpi_pci_bus);



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
