From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH -v4 1/2] lib, Make gen_pool memory allocator lockless
Date: Wed, 17 Nov 2010 19:16:01 +0800
Message-ID: <AANLkTi=F+r77f5WJpPPh2rtWgtcVqGS-qbCJZ11Fy1yN@mail.gmail.com>
References: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
	<1289868791-16658-2-git-send-email-ying.huang@intel.com>
	<20101116135038.fcaa90ca.akpm@linux-foundation.org>
	<1289960281.8719.1218.camel@yhuang-dev>
	<20101116183506.41e77e1a.akpm@linux-foundation.org>
	<1289963005.8719.1238.camel@yhuang-dev>
	<20101116195720.23287038.akpm@linux-foundation.org>
	<1289973914.8719.1261.camel@yhuang-dev>
	<1289990983.2109.678.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37087 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933515Ab0KQLQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2010 06:16:03 -0500
In-Reply-To: <1289990983.2109.678.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Steven Rostedt <rostedt@goodmis.org>

On Wed, Nov 17, 2010 at 6:49 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
> On Wed, 2010-11-17 at 14:05 +0800, Huang Ying wrote:
>> Hi, Peter,
>>
>> Do you think think irq_work should depend on that? =C2=A0Or we just
>> reimplement irq_work based on lockless list and make irq_work depend=
s on
>> lockless list?
>
> If you can make it use a lockless list thing that's fine.

I will try to do that.

> I'm not sure Andrew's CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG makes much se=
nse
> for CONFIG_ARCH_HAVE_NMI=3Dn though..

Sorry, I do not find ARCH_HAVE_NMI in any Kconfig, can you help me to
point out? I think cmpxchg can be used safely in lock-less code on
architectures without NMI.

> Anyway, make sure to consolidate net/rds/xlist.h and its users, havin=
g
> two lockless lists is one too many.

Sure.

>> At least as the first step, I prefer to just make lockless list depe=
nd
>> on CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG.
>
> But only if the platform has NMIs, otherwise its moot.

Yes.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
