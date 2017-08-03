From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: clear error status before acknowledging the
 error
Date: Thu, 3 Aug 2017 16:06:22 -0600
Message-ID: <82fe23f6-efd8-d256-7f34-a0bbc91237d3@codeaurora.org>
References: <1501280703-21471-1-git-send-email-tbaicar@codeaurora.org>
 <20170729065345.GA30608@nazgul.tnic>
 <fd826be1-50b0-1f82-3fb3-a32a356c45c4@codeaurora.org>
 <20170731170017.2vwxhewivgpyvpea@intel.com>
 <01b3550d-1fca-c051-3581-41dda3b62779@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01b3550d-1fca-c051-3581-41dda3b62779@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 7/31/2017 11:44 AM, Baicar, Tyler wrote:
> On 7/31/2017 11:00 AM, Luck, Tony wrote:
>> On Mon, Jul 31, 2017 at 10:15:27AM -0600, Baicar, Tyler wrote:
>>> I think the better thing to do in this case is still send the ack. If
>>> ghes_read_estatus() fails, then
>>> either we are unable to read the estatus or the estatus is 
>>> empty/invalid.
>> Right now we silently handle that failure of ghes_read_estatus(). That
>> might be hiding some Linux bugs if we are calling ghes_proc() in cases
>> where we shouldn't.
>>
>> Perhaps we should have something like this, so if systems do start 
>> acting
>> weirdly there will be a note that we took this path:
>>
>>     rc = ghes_read_estatus(ghes, 0);
>>     if (rc) {
>>         pr_notice("surprise failure reading ghes estatus\n");
>>         goto out;
>>     }
> Thank you Tony for the feedback, I can add a print like this in the 
> next version. I'll verify that
> rc is not -ENOENT though so we don't print it on empty scenarios since 
> the polled source
> will be hitting this path frequently.
>
Hi Tony,

I think I'm going to avoid adding this print, the failures are reported 
in prints in ghes_read_estatus(), so it looks a little redundant:

[  133.601165] [Firmware Warn]: GHES: Failed to read error status block!
[  133.601167] surprise failure reading GHES estatus

Thanks,
Tyler
>>
>>> If we do not send the ack, then we will be in a scenario where FW 
>>> will not
>>> send any more errors.
>> We might ACK something that the firmware didn't send, which may
>> lead to other problems.
>>
>>> I think it would be better to still have the FW send the errors and 
>>> kernel
>>> complain about issues with
>> But I agree with this. We should send the ACK.  Luckliy this doesn't 
>> have
>> a long legacy problem because the whole ACK mechanism is a new thing. So
>> we only have to worry about GHESv2 supporting BIOS.
>>
>> -Tony
>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
