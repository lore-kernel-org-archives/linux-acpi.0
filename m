From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] Add decaying history logic to cpuidle menu idle
	predictor
Date: Wed, 31 Dec 2008 11:46:36 -0800
Message-ID: <7E82351C108FA840AB1866AC776AEC464383824C@orsmsx505.amr.corp.intel.com>
References: <20081230224602.GA6898@linux-os.sc.intel.com>
 <1230686867.4091.110.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3974 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbYLaTqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 14:46:30 -0500
In-Reply-To: <1230686867.4091.110.camel@yakui_zhao.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


>-----Original Message-----
>From: Zhao, Yakui 
>Sent: Tuesday, December 30, 2008 5:28 PM
>To: Pallipadi, Venkatesh
>Cc: Len Brown; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] Add decaying history logic to cpuidle 
>menu idle predictor
>
>On Wed, 2008-12-31 at 06:46 +0800, Pallipadi, Venkatesh wrote:
>> Add decaying history of predicted idle time, instead of 
>using the last early
>> wakeup. This logic helps menu governor do better job of 
>predicting idle time.
>> 
>> With this change, we also measured noticable (~8%) power savings on
>> a DP server system with CPUs supporting deep C states, when system
>> was lightly loaded. There was no change to power or perf on 
>other load
>> conditions.
>> 
>> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>> 
>> ---
>>  drivers/cpuidle/governors/menu.c |   10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> Index: linux-2.6/drivers/cpuidle/governors/menu.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/cpuidle/governors/menu.c	
>2008-11-10 15:27:13.000000000 -0800
>> +++ linux-2.6/drivers/cpuidle/governors/menu.c	
>2008-12-30 14:39:15.000000000 -0800
>> @@ -15,12 +15,14 @@
>>  #include <linux/tick.h>
>>  
>>  #define BREAK_FUZZ	4	/* 4 us */
>> +#define PRED_HISTORY_PCT	50
>Hi, Venki
>   It seems that the history factor is fixed to 50%. 
>   How about adding an interface to change the history factor?
>

Yakui,

50% seems to be reasonable default across all platforms we have checked. We still
have to get some more data to see 25% works better on all platforms.

I considered adding a boot parameter or /sysfs tunable for this. Even though
such options are good for developers, most of the time, any option like that
will get misused at the end user/distro level.

So, this is the simple patch that helps in most cases. Going forward, we have
options like
1 One single constant factor for all platforms
2 Different factor for different platforms, based on CPU type (HT, multi-core, etc)
3 History factor that varies over time, based on right or wrong predictions

My gut feeling is that we may end up with 3 in future. But, I wanted to get the
basic code in now with options to optimize in future.

Thanks,
Venki