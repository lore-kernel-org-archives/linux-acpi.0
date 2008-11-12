From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [GIT PULL] ACPI patches for Linux-2.6.28-rc4
Date: Wed, 12 Nov 2008 11:40:20 +0000
Message-ID: <491AC0A4.4000009@tuffmail.co.uk>
References: <alpine.LFD.2.00.0811112126430.12712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:7989 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYKLLkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 06:40:25 -0500
Received: by nf-out-0910.google.com with SMTP id d3so188100nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2008 03:40:24 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811112126430.12712@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Len Brown wrote:
> Hi Linus,
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> Two .28 regression fixes.
> Some video patches shipping in SuSE that I should have included earlier.
> Some EC patches to deal with some out of spec hardware

I tested this for the EC patches.  It works fine, so I've no complaint.  Just FYI, the lowered interrupt storm threshold now triggers on my EeePC (701).

I think it used to trigger originally, then the "fast transaction" / transaction from interrupt patch reduced the number of spurious interrupts.  So fwiw, I agree that it was reasonable to lower the threshold.

Thanks for your hard work Alex!
I think this is going to be the first mainline kernel to really run well on the original EeePC.

Alan
