From: Xiaotian Feng <dfeng@redhat.com>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or 	in_atomic
Date: Wed, 09 Dec 2009 09:54:10 +0800
Message-ID: <4B1F0342.9080401@redhat.com>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com> <dd18b0c30912032250k7502c751mb8aefe7f915a281b@mail.gmail.com> <4B18B4CA.5060602@redhat.com> <4B18B9FC.5030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14205 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbZLIBya (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2009 20:54:30 -0500
In-Reply-To: <4B18B9FC.5030309@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/04/2009 03:27 PM, Justin P. Mattock wrote:
> On 12/03/09 23:05, Danny Feng wrote:
>> On 12/04/2009 02:50 PM, Justin Mattock wrote:
>>> On Thu, Dec 3, 2009 at 8:26 PM, Xiaotian Feng<dfeng@redhat.com> wrote:
>>>> commit 8bd108d adds preemption point after each opcode parse, then
>>>> a sleeping function called from invalid context bug was founded
>>>> during suspend/resume stage. this was fixed in commit abe1dfa by
>>>> don't cond_resched when irq_disabled. But recent commit 138d156 
>>>> changes
>>>> the behaviour to don't cond_resched when in_atomic. This makes the
>>>> sleeping function called from invalid context bug happen again, which
>>>> is reported in http://lkml.org/lkml/2009/12/1/371.
>>>>
>>>> The fix is to cond_sched() only when preemptible, which means not in
>>>> irq_disabled or in_atomic.
>>>>
>>>> Reported-and-bisected-by: Larry Finger<Larry.Finger@lwfinger.net>
>>>> Signed-off-by: Xiaotian Feng<dfeng@redhat.com>
>>>> ---
>>>> include/acpi/platform/aclinux.h | 2 +-
>>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/include/acpi/platform/aclinux.h
>>>> b/include/acpi/platform/aclinux.h
>>>> index 9d7febd..5b415ee 100644
>>>> --- a/include/acpi/platform/aclinux.h
>>>> +++ b/include/acpi/platform/aclinux.h
>>>> @@ -152,7 +152,7 @@ static inline void
>>>> *acpi_os_acquire_object(acpi_cache_t * cache)
>>>> #include<linux/hardirq.h>
>>>> #define ACPI_PREEMPTION_POINT() \
>>>> do { \
>>>> - if (!in_atomic_preempt_off()) \
>>>> + if (preemptible()) \
>>>> cond_resched(); \
>>>> } while (0)
>>>>
>>>> -- 
>>>> 1.6.5.2
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-kernel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at http://www.tux.org/lkml/
>>>>
>>>
>>> looks good
>>> kernel compiled without any issues,
>>> echo mem> /sys/power/state
>>> reported no warning message.
>>>
>>> Also if you don't mind add:
>>> Reported-and-bisected-by: Justin P. Mattock<justinmattock@gmail.com>
>>>
>> Sure, sorry for I had missed thread for
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=14483
>>
>>> Id like to get some kind of credit for this b*tch.
>>>
>>
>>
>
> no worries.. I'll run
> my system with this change
> to see if anything happens.
>

Any feedbacks?

Regards
Xiaotian

> As for the bug, leave it open
> until this makes it's way into
> the main kernel, then rafael can
> close it
>
> Justin P. Mattock
>

