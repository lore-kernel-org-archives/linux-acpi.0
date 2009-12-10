From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or in_atomic
Date: Thu, 10 Dec 2009 20:58:45 +0300
Message-ID: <4B2136D5.1030402@gmail.com>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com> <20091210100907.GA2446@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:53007 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761059AbZLJR6l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 12:58:41 -0500
In-Reply-To: <20091210100907.GA2446@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Xiaotian Feng <dfeng@redhat.com>, lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pavel,

Please elaborate... Your comments "ugly as hell" are too often to be
specific...
There is only one use of ACPI_PREEMPTION_POINT(), and it is in the
ACPICA code,
which we all agreed to keep OS independent, thus the need for #define.
Do you see any other way to add preemption point without introducing
Linux-specific
code into ACPICA?

Thanks,
Alex.


Pavel Machek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri 2009-12-04 12:26:00, Xiaotian Feng wrote:
>  =20
>> commit 8bd108d adds preemption point after each opcode parse, then
>> a sleeping function called from invalid context bug was founded
>> during suspend/resume stage. this was fixed in commit abe1dfa by
>> don't cond_resched when irq_disabled. But recent commit 138d156 chan=
ges
>> the behaviour to don't cond_resched when in_atomic. This makes the
>> sleeping function called from invalid context bug happen again, whic=
h
>> is reported in http://lkml.org/lkml/2009/12/1/371.
>>
>> The fix is to cond_sched() only when preemptible, which means not in
>> irq_disabled or in_atomic.
>>
>> @@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_=
cache_t * cache)
>>  #include <linux/hardirq.h>
>>  #define ACPI_PREEMPTION_POINT() \
>>  	do { \
>> -		if (!in_atomic_preempt_off()) \
>> +		if (preemptible()) \
>>  			cond_resched(); \
>>  	} while (0)
>>    =20
>
> Note that this is ugly as hell. It means we have two acpi
> interpretters in kernel, one for preemptible, one for non-preemptible=
,
> with very different behaviour.
>
> It would be slightly nicer to pass the "preemptible" info explicitely=
,
> as function parameters.
>
> It would be even better not to need that difference.
>
> 									Pavel
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
