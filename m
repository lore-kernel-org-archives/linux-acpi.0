From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpi/apei/erst: Remove "Error" from initialization and
 disable output
Date: Tue, 18 Jul 2017 07:29:40 -0400
Message-ID: <0fb91e9d-5446-aa6e-2eea-c455538c4c1a@redhat.com>
References: <1500337283-25734-1-git-send-email-prarit@redhat.com>
 <20170718052627.GA8741@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdGRL3m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 07:29:42 -0400
In-Reply-To: <20170718052627.GA8741@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-acpi@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ying.huang@intel.com



On 07/18/2017 01:26 AM, Borislav Petkov wrote:
> On Mon, Jul 17, 2017 at 08:21:23PM -0400, Prarit Bhargava wrote:
>> The word "Error" is used by many QA groups and users as a keyword to
>> indicate that there is a critical failure during system bootup. The ESRT
>> code would interact better with these scripts
> 
> ... which is a thinly veiled way of saying: my scripts can't
> differentiate between an error being reported and the word "error" so
> let's "fix" the kernel.
> 
> Jeez. Fix your scripts instead.
> 

Boris, I'd agree with you but this is one of those places where I think we
should bend a bit.  Error and Warning are indications of a failure, and we
should consider special casing them.  I would agree if this were one or two
scripts but I've heard complaints from 3 different companies about this.

It's a minor fix in the grander scheme of things.

P.
