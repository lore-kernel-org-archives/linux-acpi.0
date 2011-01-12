From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 14/48] PM: Fix oops in suspend/hibernate code related
 to failing ioremap()
Date: Wed, 12 Jan 2011 10:42:33 -0800
Message-ID: <4D2DF619.5@oracle.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>	<26fcaf60fe3861409eb4c455c5c0d0f00f599b08.1294827492.git.len.brown@intel.com>	<4D2DF557.8030403@suse.cz> <20110112104027.f3fc302b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:38943 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab1ALSm7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:42:59 -0500
In-Reply-To: <20110112104027.f3fc302b.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

On 01/12/11 10:40, Randy Dunlap wrote:
> On Wed, 12 Jan 2011 19:39:19 +0100 Jiri Slaby wrote:
> 
>> On 01/12/2011 11:19 AM, Len Brown wrote:
>>> @@ -271,7 +271,7 @@ static inline int suspend_nvs_register(unsigned long a, unsigned long b)
>>>  }
>>>  static inline int suspend_nvs_alloc(void) { return 0; }
>>>  static inline void suspend_nvs_free(void) {}
>>> -static inline void suspend_nvs_save(void) {}
>>> +static inline int suspend_nvs_save(void) {}
>>
>> Aiee, I've just noticed, this needs to return something, otherwise a
>> warning is generated for !CONFIG_SUSPEND_NVS.
>>
>> What's better for you, a followup or resend?
> 
> Yeah, I just made a patch for that, but I'll leave it up to
> you and Len to haggle about.


Not that Len cares, but there is also this build error when
ACPI is not enabled:

arch/x86/kernel/e820.c:734: error:implicit declaration of function 'suspend_nvs_register'


I also have a patch for it.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
