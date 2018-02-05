From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Bug 197863] Thinkpad X240 resume dramatically slower on kernels
 4.13+
Date: Mon, 5 Feb 2018 11:55:27 +0100
Message-ID: <fe58e542-81c6-9c44-8930-7d91120e80cb@intel.com>
References: <bug-197863-190391@https.bugzilla.kernel.org/>
 <bug-197863-190391-0fyd51NsnV@https.bugzilla.kernel.org/>
 <20180129182109.neh34gh7uaxymcb5@victor> <20180130063204.GA8652@kroah.com>
 <20180203182554.rpjvmjbptuqemul2@victor> <20180204061804.GB31023@kroah.com>
 <874lmw33fe.fsf@miraculix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19241 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeBEKzd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 05:55:33 -0500
In-Reply-To: <874lmw33fe.fsf@miraculix.mork.no>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
Cc: Greg KH <gregkh@linuxfoundation.org>, Markus Demleitner <m@tfiu.de>, Lv Zheng <lv.zheng@intel.com>, Andreas Lindhe <andreas@lindhe.io>, Gjorgji Jankovski <j.gjorgji@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Fernando Chaves <nanochaves@gmail.com>, Tomislav Ivek <tomislav.ivek@gmail.com>, "Denis P." <theoriginal.skullburner@gmail.com>, All applicable <stable@vger.kernel.org>, linux-usb@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2/4/2018 9:28 PM, Bjørn Mork wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
>> On Sat, Feb 03, 2018 at 07:25:54PM +0100, Markus Demleitner wrote:
>>
>>> It's 662591461c4b9a1e3b9b159dbf37648a585ebaae.  To my eyes, it even
>>> looks plausible that it's causing the problematic behaviour, but
>>> since I can't say I understand what I'd be doing if I dabbled with
>>> the change, I've refrained from guessing how to fix it.
>>>
>>> I'm happy to try patches, though.
>> Ok, thanks.  I've added the authors of this patch to the email here,
>> perhaps they have an idea of what is going on?
> This thing made me curious enough to dive into code I don't understand,
> as I have experienced the annoying crazy fan behaviour in resume a few
> times on my X1 Carbon 4th gen.
>
> Maybe I missed something, but it looks like commit
>
>   c3a696b6e8f8 ("ACPI / EC: Use busy polling mode when GPE is not enabled")
>
> introduced suspend/resume busy polling for the "boot EC" unintentionally?
>
> The patch moved acpi_ec_leave_noirq() and acpi_ec_leave_noirq()
> functions outside the #ifdef CONFIG_PM_SLEEP, so they could be reused
> while installing handlers.  But when doing that the
>
>         if (ec == first_ec)
>
> conditions on suspend/resume were silently dropped.  I assume the
> intention might have been to move those intto acpi_ec_suspend_noirq()
> and acpi_ec_resume_noirq() instead? But that didn't happen AFAICS.
>
> Or did I misunderstand this completely?  Not unlikely given that I have
> zero clue about what this code is doing...
>
> But I do wonder if the attached (completely untested!!) patch makes
> things any better?

I don't think so, the macro is needed too.

I'll queue up a full revert of 662591461c4b9a1e3b.

Thanks,
Rafael

