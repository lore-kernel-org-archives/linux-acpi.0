From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or in_atomic
Date: Thu, 10 Dec 2009 14:46:02 -0800
Message-ID: <4B217A2A.2040708@gmail.com>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com> <20091210100907.GA2446@ucw.cz> <4B2136D5.1030402@gmail.com> <20091210181800.GM19454@elf.ucw.cz> <4B214007.2080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:63012 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbZLJWpk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 17:45:40 -0500
In-Reply-To: <4B214007.2080409@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Xiaotian Feng <dfeng@redhat.com>, lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/09 10:37, Alexey Starikovskiy wrote:
> Pavel Machek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On Thu 2009-12-10 20:58:45, Alexey Starikovskiy wrote:
>>
>>> Hi Pavel,
>>>
>>> Please elaborate... Your comments "ugly as hell" are too often to b=
e
>>> specific...
>>> There is only one use of ACPI_PREEMPTION_POINT(), and it is in the
>>> ACPICA code,
>>> which we all agreed to keep OS independent, thus the need for #defi=
ne.
>>> Do you see any other way to add preemption point without introducin=
g
>>> Linux-specific
>>> code into ACPICA?
>>>
>>
>> I believe we want linux-specific code in acpica at this point.
>>
>>
> The point there we call cond_resched() in ACPICA is an interpreter pa=
rse
> loop. This parse loop may be executed from within atomic context and =
even
> with interrupts off. In this case, cond_resched() should not be calle=
d
> to not make
> might_sleep() guards angry.
>
> Please post the code, which will do the above and will not look "ugly=
 as
> hell".
> I still don't follow your vague comments.
>> (Or maybe... I guess other systems have concept of preemption and no=
t
>> all actions are permitted from all contexts, so maybe something like
>> that would be important for them, too?)
>>
> None of them cared about it up to this point.
> With the macro above we allowed them to follow Linux, but to go or no=
t
> is their call.
>
> Regards,
> Alex.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

o.k. I went did a pull to update
the kernel, and then changed
aclinux.h to the above post.

I'm am not seeing this warning message
upon wake-up.
but with the acpi merge stuff with
acpi_walk_namespace seems to break nvidia
(nvidia's problem now)

there is also some thing where the machine
takes a good 30 secs or so to wake up
(not sure if this is from the updated patch)
in dmesg I see:

platform microcode: firmware requesting intel-ucode/06-17-0a
firmware microcode: parent mocrocode should not be sleeping.

I'm thinking I need something in /lib/firmare

Justin P. Mattock
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
