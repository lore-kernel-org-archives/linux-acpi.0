From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] Documentation / cpu hotplug: remove outdated description
 for MADT entries
Date: Fri, 21 Jun 2013 10:16:14 +0800
Message-ID: <51C3B76E.1090300@linaro.org>
References: <1371718482-452-1-git-send-email-hanjun.guo@linaro.org> <3504197.mRYUAZnZ9p@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:45951 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422877Ab3FUCRO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2013 22:17:14 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so7028809pbc.17
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2013 19:17:13 -0700 (PDT)
In-Reply-To: <3504197.mRYUAZnZ9p@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Rob Landley <rob@landley.net>, Rusty Russell <rusty@rustcorp.com.au>, Srivatsa Vaddagiri <vatsa@in.ibm.com>, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 2013-6-21 3:52, Rafael J. Wysocki wrote:
> On Thursday, June 20, 2013 04:54:42 PM Hanjun Guo wrote:
>> More than 256 entries in ACPI MADT is supported from ACPI 3.0 Specification,
>> So the outdated description for MADT entries should be removed.
> 
> Well, it kind of is still valid for systems pre-dating ACPI 3.0, isn't it?

Yes, it is.

> 
> So perhaps instead of simply removing that information it would be better to
> rephrase it?

Good idea, I will update my patch and send out soon.

Thanks
Hanjun

> 
> Thanks,
> Rafael
> 
> 
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  Documentation/cpu-hotplug.txt |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
>> index 9f40135..2e36e40 100644
>> --- a/Documentation/cpu-hotplug.txt
>> +++ b/Documentation/cpu-hotplug.txt
>> @@ -370,9 +370,6 @@ A: There is no clear spec defined way from ACPI that can give us that
>>     CPUs in MADT as hotpluggable CPUS.  In the case there are no disabled CPUS
>>     we assume 1/2 the number of CPUs currently present can be hotplugged.
>>  
>> -   Caveat: Today's ACPI MADT can only provide 256 entries since the apicid field
>> -   in MADT is only 8 bits.
>> -
>>  User Space Notification
>>  
>>  Hotplug support for devices is common in Linux today. Its being used today to
>>

