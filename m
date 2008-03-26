From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc6
Date: Wed, 26 Mar 2008 09:16:53 +0100
Message-ID: <20080326081653.GA8247@elte.hu>
References: <200803180510.47670.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47069 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbYCZIRT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 04:17:19 -0400
Content-Disposition: inline
In-Reply-To: <200803180510.47670.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org


* Len Brown <lenb@kernel.org> wrote:

> Hi Linus,
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> This will update the files shown below.

btw., saw this ACPI-ish commit in rc7:

| commit b97d4803400a4442b0e4ae14d0bd8e83994b9004
| Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
| Date:   Tue Mar 25 11:21:11 2008 -0600
|
|    ACPI: fix Medion _PRT quirk (use "ISA_", not "ISA")

a grep shows that we've got one other case of an "ISA" string in the 
ACPI code - is the patch below needed too?

	Ingo

-------------------->
Subject: acpi: fix asus isa
From: Ingo Molnar <mingo@elte.hu>
Date: Wed Mar 26 09:05:07 CET 2008

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/acpi/asus_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-x86.q/drivers/acpi/asus_acpi.c
===================================================================
--- linux-x86.q.orig/drivers/acpi/asus_acpi.c
+++ linux-x86.q/drivers/acpi/asus_acpi.c
@@ -149,7 +149,7 @@ struct asus_hotk {
 };
 
 /* Here we go */
-#define A1x_PREFIX "\\_SB.PCI0.ISA.EC0."
+#define A1x_PREFIX "\\_SB.PCI0.ISA_.EC0."
 #define L3C_PREFIX "\\_SB.PCI0.PX40.ECD0."
 #define M1A_PREFIX "\\_SB.PCI0.PX40.EC0."
 #define P30_PREFIX "\\_SB.PCI0.LPCB.EC0."
