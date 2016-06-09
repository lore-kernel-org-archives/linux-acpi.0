From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next boots then hangs...
Date: Fri, 10 Jun 2016 01:40:21 +0200
Message-ID: <f3c64945-ff99-5afa-057b-b3734c0e3b39@intel.com>
References: <CAOg9mSTG08zt8PNjDZ4zKXxFUVyW9-AzjRLreHjN5ETuoqh-Rg@mail.gmail.com>
 <1574a35b-a0e5-2ec0-f19e-8ff01ae5eec0@intel.com>
 <CAOg9mSRYcD9+P+914WY5_iLUWb4ZwXnQ02avtM3vV5+LiWsrXQ@mail.gmail.com>
 <cface69a-ce21-3faf-bca9-267ddf05237a@intel.com>
 <CAOg9mSQPGpSOm0ef0rJWFObyBriSEZwDzEAJi3dNtRCjygHyuQ@mail.gmail.com>
 <CAOg9mSSwRGZqQXhwQVi0=OG8xGqdFZbrHuNLSydL0WBziA2haQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44372 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbcFIXk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Jun 2016 19:40:26 -0400
In-Reply-To: <CAOg9mSSwRGZqQXhwQVi0=OG8xGqdFZbrHuNLSydL0WBziA2haQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Marshall <hubcap@omnibond.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org, "Zheng, Lv" <lv.zheng@intel.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

Let's involve the author of the commits in question (and CC linux-acpi too).

On 6/8/2016 6:18 PM, Mike Marshall wrote:
> Hello everyone...
>
> The problem is gone today, and it looks like Rafael
> dropped the ACPICA changes from linux-next.

Indeed, I did that.

Now, it would be good if you could help to identify which of them 
exactly introduced the problem.

Those patches are available in the kernel.org Patchwork as:

https://patchwork.kernel.org/patch/9087951/
https://patchwork.kernel.org/patch/9088001/
https://patchwork.kernel.org/patch/9088021/
https://patchwork.kernel.org/patch/9087971/

plus one fix on top of them:

https://patchwork.kernel.org/patch/9157765/

The ordering of the links above should reflect the correct order of the 
patches (or you can verify that by looking at their subjects).

Can you please try to apply them one by one (they should apply on top of 
the current mainline) and see which one breaks things for you?

Thanks,
Rafael


> Now linux-next has an Oops at leaf_walk_rcu and
> is not usable <g>... I think I see people on LKML
> talking about it.
>
> Thanks...
>
> -Mike
>
> On Tue, Jun 7, 2016 at 2:58 PM, Mike Marshall <hubcap@omnibond.com> wrote:
>> Well, I started the bisect again, using Paolo's suggestion.
>>
>> It lead me in a circle back to 407aa3f.
>>
>> It could be that I'm not competent to perform this bisect, barring
>> that - it could be that the "bad" code only emerged as the result
>> of 407aa3f, which, according to the commit message, was a merge of
>> 41 commits...
>>
>> As to my bisect competency, sometimes (usually) the next bisect point
>> would be a place where 7f9bef9 wouldn't apply. I would only find out
>> that 7f9bef9 wouldn't apply by running the cherry pick, so each time
>> I'd have to clean up the failed cherry pick before I could continue,
>> which I did like this:
>>
>> git cherry-pick -n 7f9bef9                    <-- fail
>>
>> git reset HEAD drivers/acpi/acpica/hwregs.c   <-- to unstage
>>
>> git checkout -- drivers/acpi/acpica/hwregs.c  <-- discard cherry pick wreckage
>>
>> Anyhow, I hope I'm being helpful, and not obstructionist, by trying
>> to follow up on this. Good luck Rafael, I'll definitely try
>> linux-next tomorrow.
>>
>> # git bisect log
>> git bisect start
>> # bad: [407aa3ff6f54ea2be7959639d664ae5183e2e9f8] Merge branch 'acpica'
>> git bisect bad 407aa3ff6f54ea2be7959639d664ae5183e2e9f8
>> # good: [7f9bef9debafcb767d00efb177d0f2edd4940eab] ACPICA / Hardware:
>> Fix old register check in acpi_hw_get_access_bit_width()
>> git bisect good 7f9bef9debafcb767d00efb177d0f2edd4940eab
>> # good: [d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a] Merge back new
>> ACPICA material for v4.7.
>> git bisect good d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a
>> # good: [d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a] Merge back new
>> ACPICA material for v4.7.
>> git bisect good d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a
>> # good: [21a9703de3045cda0b3aaa5bc193d2e1062908d2] Merge branch
>> 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
>> git bisect good 21a9703de3045cda0b3aaa5bc193d2e1062908d2
>> # good: [dd287690b0aa4b0d22e8dd7dd2cb3055f5141a27] Merge tag
>> 'arc-4.6-rc7-fixes' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc
>> git bisect good dd287690b0aa4b0d22e8dd7dd2cb3055f5141a27
>> # good: [35cd3f4563c4a0fc99be300afc7b82a822e634c7] Merge branch
>> 'for-4.6-fixes' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
>> git bisect good 35cd3f4563c4a0fc99be300afc7b82a822e634c7
>> # good: [3f8f0cf2eddb558e5ccf9b155e758f4b950d8697] Merge tag
>> 'usb-4.6-rc7' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>> git bisect good 3f8f0cf2eddb558e5ccf9b155e758f4b950d8697
>> # good: [2b86c4a84377b74a6ec0ec9463feb0803bcb1066] Merge tag
>> 'iio-fixes-for-4.6d' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
>> staging-linus
>> git bisect good 2b86c4a84377b74a6ec0ec9463feb0803bcb1066
>> # good: [d1306eb675ad7a9a760b6b8e8e189824b8db89e7] nvmem: mxs-ocotp:
>> fix buffer overflow in read
>> git bisect good d1306eb675ad7a9a760b6b8e8e189824b8db89e7
>> # good: [32cf95db22d49cf4a3b421ba9fd156bb5f920ebb] Merge tag
>> 'char-misc-4.6-rc7' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
>> git bisect good 32cf95db22d49cf4a3b421ba9fd156bb5f920ebb
>> # good: [44549e8f5eea4e0a41b487b63e616cb089922b99] Linux 4.6-rc7
>> git bisect good 44549e8f5eea4e0a41b487b63e616cb089922b99
>> # first bad commit: [407aa3ff6f54ea2be7959639d664ae5183e2e9f8] Merge
>> branch 'acpica'
>>
>> On Tue, Jun 7, 2016 at 11:14 AM, Rafael J. Wysocki
>> <rafael.j.wysocki@intel.com> wrote:
>>> On 6/7/2016 5:08 PM, Mike Marshall wrote:
>>>> I'm one of the original reporters and testers of that problem/fix...
>>>> my current problem started after that... I've tested
>>>> next-20160607 and 4.7.0-rc2-00004-g3613a62 (Linus' tree
>>>> of the moment) so far today... Linus' tree is still OK (because
>>>> it has 7f9bef9) and linux-next is still busted (for me).
>>>>
>>>> I'll keep on bisecting using the suggestions that Paolo sent...
>>>
>>> I see.
>>>
>>> I think I'll need to drop the latest ACPICA changes from linux-next then.
>>>
>>> Let me try to do that and please test linux-next again tomorrow.
>>>
>>> Thanks,
>>> Rafael
>>>
>>>
>>>
>>>> On Tue, Jun 7, 2016 at 10:55 AM, Rafael J. Wysocki
>>>> <rafael.j.wysocki@intel.com> wrote:
>>>>> On 6/6/2016 10:56 PM, Mike Marshall wrote:
>>>>>> Greetings...
>>>>>>
>>>>>> Please keep my email in the loop on this, I'm only subscribed
>>>>>> to fs-devel...
>>>>>>
>>>>>> Linux-next fails to boot properly for me, but Linux 4.7-rc2 from
>>>>>> Linus' tree boots fine.
>>>>>>
>>>>>> I got started bisecting next-20160603 last Friday, but didn't get done.
>>>>>>
>>>>>> git bisect start '64289ca' '7f9bef9'
>>>>>>
>>>>>> I picked 7f9bef9 as the good commit to start with because I knew
>>>>>> I needed 7f9bef9 or else my QEMU-KVM would crash. Before I started
>>>>>> the bisection, I verified that 7f9bef9 was indeed good by checking
>>>>>> out a branch from next-20160603 with 7f9bef9 as the HEAD and
>>>>>> building it: git checkout -b gas 7f9bef9
>>>>>>
>>>>>> Today I got next-20160606 and checked to see if the same failure
>>>>>> occurred - it did. So I continued with the bisection of next-20160603.
>>>>>>
>>>>>> I arrived at 407aa3ff6f54ea2be7959639d664ae5183e2e9f8 as the bad commit.
>>>>>>
>>>>>>
>>>>>> 407aa3f is a rather complex commit... there is a problem with it,
>>>>>> but I'm not sure what to do next... both 7f9bef9 and 407aa3f are
>>>>>> related to ACPICA...
>>>>>
>>>>> It looks like this commit
>>>>>
>>>>>
>>>>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpica-fixes&id=7f9bef9debafcb767d00efb177d0f2edd4940eab
>>>>>
>>>>> should fix the problem for you.
>>>>>
>>>>> Thanks,
>>>>> Rafael
>>>>>

