From: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/2] x86/MCE: Export memory_error()
Date: Tue, 25 Apr 2017 15:07:41 -0600
Message-ID: <20170425210740.GA15722@omniknight.lm.intel.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
 <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
 <1492804517.2738.25.camel@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F6127653B@ORSMSX114.amr.corp.intel.com>
 <CAPcyv4jAkCE2QBuxfxxmZfQZLCVOGLrLXqDu5TyGCVA+xJMEVg@mail.gmail.com>
 <20170421202741.GA16423@intel.com>
 <20170421210704.c5pvpn6zivvruzx3@pd.tnic>
 <20170424113620.6iq2466yhkhb33rp@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:11646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1951021AbdDYVJD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Apr 2017 17:09:03 -0400
Content-Disposition: inline
In-Reply-To: <20170424113620.6iq2466yhkhb33rp@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 04/24, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 24 Apr 2017 13:16:50 +0200
> Subject: [PATCH 1/2] x86/MCE: Export memory_error()
> 
> Export the function which checks whether an MCE is a memory error to
> other users so that we can reuse the logic. Drop the boot_cpu_data use,
> while at it, as mce.cpuvendor already has the CPU vendor in there.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/mce.h       |  1 +
>  arch/x86/kernel/cpu/mcheck/mce.c | 12 +++++-------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
Here is the updated patch to use the above helper:

8<-----


>From 9661a85799c9067d762ecf29630f2b7f69897628 Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 25 Apr 2017 15:00:58 -0600
Subject: [PATCH v2] acpi, nfit: fix the memory error check in nfit_handle_mce

The check for an MCE being a memory error in the NFIT mce handler was
bogus. Export the new mce_is_memory_error helper, and use that tp
perform the correct check in the handler.

Reported-by: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 1 +
 drivers/acpi/nfit/mce.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

This applies on tip/master + Borislav's patches in this thread above.
I'm not sure what the right process for queueing this for both
upstream and -stable is, so just replying here. Should I post it
independently?

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 361865ca..5cfbaeb 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -527,6 +527,7 @@ bool mce_is_memory_error(struct mce *m)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
 static bool cec_add_mce(struct mce *m)
 {
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index 3ba1c34..fd86bec 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -26,7 +26,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	struct nfit_spa *nfit_spa;
 
 	/* We only care about memory errors */
-	if (!(mce->status & MCACOD))
+	if (!mce_is_memory_error(mce))
 		return NOTIFY_DONE;
 
 	/*
-- 
2.9.3

