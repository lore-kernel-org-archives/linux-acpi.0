From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Date: Wed, 30 Aug 2017 00:19:32 +0200
Message-ID: <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
 <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50009 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751240AbdH2WTu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 18:19:50 -0400
Content-Disposition: inline
In-Reply-To: <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>, Tony Luck <tony.luck@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 29, 2017 at 03:27:42PM -0600, Baicar, Tyler wrote:
> To avoid calling the
> do_recovery() function for correctable errors I created
> https://patchwork.kernel.org/patch/9925877/

enum {
        GHES_SEV_NO = 0x0,
        GHES_SEV_CORRECTED = 0x1,
        GHES_SEV_RECOVERABLE = 0x2,
        GHES_SEV_PANIC = 0x3,
};

>From all those severity types above, you want to do recovery for
GHES_SEV_RECOVERABLE but print *all* severities. Yes? I mean, this is
what makes most sense: you want to dump all errors but try to recover
from those from which you *actually* have the possibility to do so.

Looking at the severities conversion, GHES_SEV_RECOVERABLE is
CPER_SEV_RECOVERABLE. cper_severity_to_aer() converts then
CPER_SEV_RECOVERABLE to AER_NONFATAL.

  [ Btw, this is the dumbest sh*t ever. Three different severities!!!
    Looks like someone has won a contest of how to design something as
    needlessly complex as possible. ]

So it looks to me like you want to do rather:

	if (entry.severity == AER_NONFATAL)
		do_recovery(pdev, entry.severity);

which should correspond to the GHES_SEV_RECOVERABLE. And this would be
the straight-forward thing and that would be fine but...

... that is still not 100% equivalent because the check is:

	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE...

so there's the severity of the estatus block and then the severity of
each section successively.

And I have no idea why we're doing this.

Because if we have to keep this, then the above simplification won't work and
you'll have to pass in a separate argument to aer_recover_queue():

	aer_recover_queue( ..., sev == GHES_SEV_RECOVERABLE &&
				sec_sev == GHES_SEV_RECOVERABLE, ...

which, if true, would mean, do recovery.

So let's find out first why do we have to look at both severities.

Tony, any ideas?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
