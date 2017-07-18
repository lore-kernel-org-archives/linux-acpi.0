From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi/apei/erst: Remove "Error" from initialization and
 disable output
Date: Tue, 18 Jul 2017 16:07:29 +0200
Message-ID: <20170718140729.GA20740@nazgul.tnic>
References: <1500337283-25734-1-git-send-email-prarit@redhat.com>
 <20170718052627.GA8741@nazgul.tnic>
 <0fb91e9d-5446-aa6e-2eea-c455538c4c1a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45671 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751401AbdGROHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 10:07:35 -0400
Content-Disposition: inline
In-Reply-To: <0fb91e9d-5446-aa6e-2eea-c455538c4c1a@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ying.huang@intel.com

On Tue, Jul 18, 2017 at 07:29:40AM -0400, Prarit Bhargava wrote:
> Boris, I'd agree with you but this is one of those places where I think we
> should bend a bit.  Error and Warning are indications of a failure, and we
> should consider special casing them.

Woahahahahah, you're killing me! I haven't laughed so hard for a while
now. Thanks, I guess...

Special-casing "error" and "warning". Stop the presses, the kernel
decided to special-case two english words. News at 11.

> I would agree if this were one or two scripts but I've heard
> complaints from 3 different companies about this.

Three companies, huh? Three *whole* companies? Or just three engineers
who can't grep?

Of course, if you say three companies, that should at least give more
weight to your already insane argument.

Here's a counter-argument: with the gazillion abbreviations in dmesg,
actually having a print statement *explain* what it is trying to say is
refreshing and really helpful.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
