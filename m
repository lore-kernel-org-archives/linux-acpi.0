From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: unregister interrupts during shutdown
Date: Thu, 7 Dec 2017 09:52:06 -0500
Message-ID: <e17a3ac6-aac3-09ee-7307-01ddc780507a@codeaurora.org>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0hEdK_vJcHeoz=Z2H6od=bktspPpTo37Y6qiOT2qptnaA@mail.gmail.com>
 <20171207082958.GA11882@kroah.com> <2960222.F3CtrQ5k26@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2960222.F3CtrQ5k26@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Rafael,

On 12/7/2017 8:00 AM, Rafael J. Wysocki wrote:
>> Just don't use devm_request_threaded_irq()?  :)
>>
>> Seriously, those are just "helper" functions if your code happens to
>> follow the pattern they provide, if not, then don't use them, it's not
>> that hard to provide the correct code to unwind things properly by "open
>> coding" this logic as needed.
>>
>> The devm_*irq() functions are known for not being able to be used all of
>> the time for lots of shutdown and cleanup issues, this isn't the first
>> time it has happened, which is why we are very careful when taking
>> "cleanup" patches that use those functions.
> I see, thanks for the clarification.
> 
> OK, we'll need to rework the driver somewhat, then.

Even if we got rid of devm_*irq() functions, I see that the free_irq() function
requires dev_id argument.

	 * There can be multiple actions per IRQ descriptor, find the right
	 * one based on the dev_id:

I still need to keep track of the dev_ids attached to request_irq() functions. 

My take away from the discussion is:
1. don't use devm family of functions for IRQ registration/free
2. still keep track of the events
3. call free_irq on shutdown.

Do you have something else on your mind?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
