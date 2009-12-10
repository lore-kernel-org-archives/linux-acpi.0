From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or in_atomic
Date: Thu, 10 Dec 2009 21:37:59 +0300
Message-ID: <4B214007.2080409@gmail.com>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com> <20091210100907.GA2446@ucw.cz> <4B2136D5.1030402@gmail.com> <20091210181800.GM19454@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:16408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761300AbZLJShx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 13:37:53 -0500
In-Reply-To: <20091210181800.GM19454@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Xiaotian Feng <dfeng@redhat.com>, lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Pavel Machek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Thu 2009-12-10 20:58:45, Alexey Starikovskiy wrote:
>  =20
>> Hi Pavel,
>>
>> Please elaborate... Your comments "ugly as hell" are too often to be
>> specific...
>> There is only one use of ACPI_PREEMPTION_POINT(), and it is in the
>> ACPICA code,
>> which we all agreed to keep OS independent, thus the need for #defin=
e.
>> Do you see any other way to add preemption point without introducing
>> Linux-specific
>> code into ACPICA?
>>    =20
>
> I believe we want linux-specific code in acpica at this point.
>
>  =20
The point there we call cond_resched() in ACPICA is an interpreter pars=
e
loop. This parse loop may be executed from within atomic context and ev=
en
with interrupts off. In this case, cond_resched() should not be called
to not make
might_sleep() guards angry.

Please post the code, which will do the above and will not look "ugly a=
s
hell".
I still don't follow your vague comments.
> (Or maybe... I guess other systems have concept of preemption and not
> all actions are permitted from all contexts, so maybe something like
> that would be important for them, too?)
>  =20
None of them cared about it up to this point.
With the macro above we allowed them to follow Linux, but to go or not
is their call.

Regards,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
