From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH 2/2] i7300_idle driver v1.55
Date: Tue, 21 Oct 2008 15:09:35 -0700
Message-ID: <7E82351C108FA840AB1866AC776AEC4637CD2743@orsmsx505.amr.corp.intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
	<e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com>
	<20081011083347.GA31918@elte.hu>
	<alpine.LFD.1.10.0810161805360.3026@localhost.localdomain>
 <20081020103214.072e3b5f.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14475 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbYJUWJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2008 18:09:37 -0400
In-Reply-To: <20081020103214.072e3b5f.randy.dunlap@oracle.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Henroid, Andrew D" <andrew.d.henroid@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>


Thanks for the review. Some comments below.

Thanks,
Venki

>-----Original Message-----
>From: Randy Dunlap [mailto:randy.dunlap@oracle.com]
>Sent: Monday, October 20, 2008 10:32 AM
>To: Len Brown
>Cc: Ingo Molnar; linux-acpi@vger.kernel.org; Linux Kernel
>Mailing List; Pallipadi, Venkatesh; Henroid, Andrew D; Linus
>Torvalds; Thomas Gleixner; H. Peter Anvin; Andi Kleen
>Subject: Re: [PATCH 2/2] i7300_idle driver v1.55
>
>On Thu, 16 Oct 2008 18:08:01 -0400 (EDT) Len Brown wrote:
>
>> Signed-off-by: Andy Henroid <andrew.d.henroid@intel.com>
>> Signed-off-by: Len Brown <len.brown@intel.com>
>> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>> ---
>>  MAINTAINERS               |    6 +
>>  arch/x86/Kconfig          |    2 +
>>  drivers/Makefile          |    1 +
>>  drivers/dma/ioat_dma.c    |    3 +
>>  drivers/idle/Kconfig      |   16 +
>>  drivers/idle/Makefile     |    2 +
>>  drivers/idle/i7300_idle.c |  674
>+++++++++++++++++++++++++++++++++++++++++++++
>
>Why not just use drivers/power/ instead of a new sub-directory?

As the driver was specific to idle system and specific to few
platforms/chipset, we decided to put it in a separate directory.
We had called the new directory as drivers/memory initially.
But, idle seemed to suit it better.

I have no issues moving this over to drivers/power. Will send a
incremental patch to move it if that suits better. But, if we
Expect other platforms to have similar platform specific idle
power savings through drivers like this, then having a separate
dir to deal with idle optimization should be better.

>> +/*
>> + * Value to set THRTLOW to when initiating throttling
>> + *  0 = No throttling
>> + *  1 = Throttle when > 4 activations per eval window
>(Maximum throttling)
>> + *  2 = Throttle when > 8 activations
>> + *  168 = Throttle when > 168 activations (Minimum throttling)
>
>Why do some numbers mean > their value (i.e., 168) but others don't?
>Is it a linear value or logarithmic or what?

That is a typo in the comment. These values are simple "multiply by 4".
So, 168 should be 672 activations, and that is the minimum
possible throttling.

>> + */
>> +#define MAX_THRTLWLIMIT              168
>> +static uint i7300_idle_thrtlowlm = 1;
>> +module_param_named(thrtlwlimit, i7300_idle_thrtlowlm, uint, 0644);
>> +MODULE_PARM_DESC(thrtlwlimit,
>> +             "Value for THRTLOWLM activation field "
>> +             "(0 = disable throttle, 1 = Max throttle, 168
>= Min throttle)");
>> +
>
>> +/* Stop I/O AT memory copy */
>> +static void i7300_idle_ioat_stop(void)
>> +{
>> +     int i;
>> +     u8 sts;
>> +
>> +     for (i = 0; i < 5; i++) {
>> +             writeb(IOAT_CHANCMD_RESET,
>> +                     ioat_chanbase + IOAT1_CHANCMD_OFFSET);
>> +
>> +             udelay(10);
>> +
>> +             sts = readq(ioat_chanbase + IOAT1_CHANSTS_OFFSET) &
>> +                     IOAT_CHANSTS_DMA_TRANSFER_STATUS;
>
>readq() returns 64 bits.  You only want to LS-byte of it here?

CHANSTS is a 64 bit register and we only use lower few bits
around here. But, agree with your comment and will change it
sts to u64 with an update patch. That will make it consistent
with other reads of this register in this file

>
>> +             if (sts != IOAT_CHANSTS_DMA_TRANSFER_STATUS_ACTIVE)
>> +                     break;
>> +
>> +     }
>> +
>> +     if (i == 5)
>> +             dprintk("failed to suspend+reset I/O AT after
>5 retries\n");
>> +
>> +}
>
>
>> +struct debugfs_file_info {
>> +     void *ptr;
>> +     char name[32];
>> +     struct dentry *file;
>> +} debugfs_file_list[] = {
>> +                             {&total_starts, "total_starts", NULL},
>> +                             {&total_us, "total_us", NULL},
>> +#ifdef DEBUG
>> +                             {&past_skip, "past_skip", NULL},
>> +#endif
>> +                             {NULL, "", NULL}
>> +                     };
>
>What is debugfs used for?  any docs for it?

It has some statistics about how many times we went
into "memory throttling" state and how long we stayed
there since the boot. And one tunable that tunes a
parameter changing the policy to start throttling.
Will document this with an update patch.

>
>Does this build/work if CONFIG_DEBUG_FS=n?

Yes. Did not see any breakage with DEBIG_FS=n

