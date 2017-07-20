From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 20 Jul 2017 13:17:32 +0200
Message-ID: <20170720111732.GC18515@nazgul.tnic>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
 <20170720110402.15313-4-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934218AbdGTLRd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 07:17:33 -0400
Content-Disposition: inline
In-Reply-To: <20170720110402.15313-4-punit.agrawal@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Jul 20, 2017 at 12:04:01PM +0100, Punit Agrawal wrote:
> When booting an ACPI enabled system that does not provide the hardware
> error source table (HEST), the ghes driver prints the following message
> in the kernel log -
> 
> [    3.460067] GHES: HEST is not enabled!
> 
> which is not helpful.
> 
> The message is also output when HEST is explicitly disabled using kernel
> command line parameter.
> 
> Drop this message. While we are touching this code, also drop similar
> message when GHES is disabled using the module parameter.

No.

To the contrary, we want to know *why* GHES/HEST doesn't get enabled when
booting. See

  dba648300e89 ("ACPI / einj: Make error paths more talkative")

for a good example why.

If anything, you should do the total opposite patch and add more
printks to the error paths so that it is obvious why GHES startup fails.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
