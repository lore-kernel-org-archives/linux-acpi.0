From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [GIT PATCH] APEI patches for Linux 3.1
Date: Thu, 4 Aug 2011 09:10:09 +0800
Message-ID: <CAC=cRTMm8w-CQrj=GodPNxk=TbumuisLWzZh0i6x=x7_=C9ugg@mail.gmail.com>
References: <alpine.LFD.2.02.1108031137590.22067@x980>
	<CA+55aFxST2J+LDMB=1ctnw2WGxV+a-cm3FE-1AjwnXMNDkt32g@mail.gmail.com>
	<alpine.LFD.2.02.1108031523080.22067@x980>
	<CA+55aFxE6b=idv+fF5h1U3EnDqHSCK2b6+36sResmhJKvAZQ3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42557 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab1HDBKK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Aug 2011 21:10:10 -0400
In-Reply-To: <CA+55aFxE6b=idv+fF5h1U3EnDqHSCK2b6+36sResmhJKvAZQ3A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

Hi, Linus,

On Thu, Aug 4, 2011 at 8:52 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 3, 2011 at 9:26 AM, Len Brown <lenb@kernel.org> wrote:
>>
>> Push went here:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.gi=
t apei-release
>
> No it didn't.
>
> Apparently it went into linux-idle.
>
> Christ, Len. You send me *two* bogus pull requests, and all your pull
> requests =C2=A0come in at the very end of the merge cycle, when I ver=
y
> clearly asked people to try hard to avoid that since I'm supposed to
> be on vacation.
>
> And several of those commits are from today, and cannot have had any =
testing.
>
> In short: even though Tony told me where to look, I'm not seeing any
> reason to pull this thing. The merge window is not for development,
> and you're simply not making me get the warm and fuzzies about this
> late pull request.

Most APEI patches have been in

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git t=
est

since July 13th, and have been in linux-next since then.  I think Len
just re-apply these patches in linux-idle tree.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
