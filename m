From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 14/48] PM: Fix oops in suspend/hibernate code related
 to failing ioremap()
Date: Wed, 12 Jan 2011 12:32:06 -0800
Message-ID: <4D2E0FC6.1000909@oracle.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <201101122105.10132.rjw@sisk.pl> <4D2E0D39.1070003@oracle.com> <201101122129.12936.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:36624 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1ALUdK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 15:33:10 -0500
In-Reply-To: <201101122129.12936.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jslaby@suse.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On 01/12/11 12:29, Rafael J. Wysocki wrote:
> On Wednesday, January 12, 2011, Randy Dunlap wrote:
>> On 01/12/11 12:05, Rafael J. Wysocki wrote:
>>> On Wednesday, January 12, 2011, Randy Dunlap wrote:
>>>> On 01/12/11 10:40, Randy Dunlap wrote:
>>>>> On Wed, 12 Jan 2011 19:39:19 +0100 Jiri Slaby wrote:
>>>>>
>>>>>> On 01/12/2011 11:19 AM, Len Brown wrote:
>>>>>>> @@ -271,7 +271,7 @@ static inline int suspend_nvs_register(unsigned long a, unsigned long b)
>>>>>>>  }
>>>>>>>  static inline int suspend_nvs_alloc(void) { return 0; }
>>>>>>>  static inline void suspend_nvs_free(void) {}
>>>>>>> -static inline void suspend_nvs_save(void) {}
>>>>>>> +static inline int suspend_nvs_save(void) {}
>>>>>>
>>>>>> Aiee, I've just noticed, this needs to return something, otherwise a
>>>>>> warning is generated for !CONFIG_SUSPEND_NVS.
>>>>>>
>>>>>> What's better for you, a followup or resend?
>>>>>
>>>>> Yeah, I just made a patch for that, but I'll leave it up to
>>>>> you and Len to haggle about.
>>>
>>> We're removing CONFIG_SUSPEND_NVS in one of the later patches, but please send
>>> the fix if it's still necessary after applying the entire series.
>>
>> Build fails in linux-next of 2011-0112.  Does that have the entire series
>> applied?
> 
> Not sure, what does it print?

Sorry, just a warning, not an error, like Jiri said:

drivers/acpi/internal.h:94: warning: no return statement in function returning non-void

>>>> Not that Len cares, but there is also this build error when
>>>> ACPI is not enabled:
>>>>
>>>> arch/x86/kernel/e820.c:734: error:implicit declaration of function 'suspend_nvs_register'
>>>>
>>>>
>>>> I also have a patch for it.
>>>
>>> Please submit it.
>>
>> Did that.
> 
> OK, got it, but I think a little different patch is needed.  Will reply to
> that message.

OK, thanks.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
