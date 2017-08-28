From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V3] acpi: apei: clear error status before acknowledging
 the error
Date: Mon, 28 Aug 2017 22:14:29 +0300
Message-ID: <CAHp75VcWa9JjERTyjduPOw-fYHVjBvP_J_-Q+LC8Vr17sUv=VQ@mail.gmail.com>
References: <1503939221-27732-1-git-send-email-tbaicar@codeaurora.org>
 <1503939660.25945.127.camel@linux.intel.com> <20170828171405.2s4rlebloi5lyhga@pd.tnic>
 <CAHp75Vdx2NG8yd-cr14hxQzEjy-V29de4nbiq0v9tWpXVxt+2w@mail.gmail.com>
 <20170828172539.5cl7baxdxxaixlri@pd.tnic> <CAHp75VeoEk0SA=0w=BN-3Q0L+GaOb9Zh=xnrPrAKrKqLYcCz4g@mail.gmail.com>
 <20170828182723.iav5lgucnuhd646f@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35246 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdH1TOb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Aug 2017 15:14:31 -0400
In-Reply-To: <20170828182723.iav5lgucnuhd646f@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, james.morse@arm.com, shiju.jose@huawei.com, Geliang Tang <geliangtang@gmail.com>, Tony Luck <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Aug 28, 2017 at 9:27 PM, Borislav Petkov <bp@suse.de> wrote:
> On Mon, Aug 28, 2017 at 08:44:21PM +0300, Andy Shevchenko wrote:
>> For my opinion, since you asked, the either case needs a comment on
>> top of that additional check.
>
> That's because the comment belongs to the v2 part of the check.

Sorry not being clear, I meant another, separate comment.

>> Separate conditionals in independent cases are, of course, better.
>
> Yes, and separate are easier to read if you read them like this:
>
> +       if (rc == -ENOENT)
> +               return rc;
>
> <--- Ok, we got the missing entry out of the way, now, here, we have a
> valid entry. Now we can concentrate on processing it further.
>
>         ... other check and ack and ...
>
> And this becomes a lot more natural when you're staring at a big function
> which does a lot of things and you concentrate only on the main path.
>
> Oh, and this is how those checks get translated to asm as there you
> don't really have compound if-statements. So if you switch your mind to
> reading such checks separately, you're practically ready to read their
> asm translation too...
>
> Anyway, this is how I see it.

Looking into commit message again I think the word 'also' creates all
this. Two separate commits might be perfect, though good enough is to
have an additional comment to the new check.

Thanks for sharing detailed point of view.

-- 
With Best Regards,
Andy Shevchenko
