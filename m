From: Lionel Debroux <lionel_debroux@yahoo.fr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Wed, 26 Jan 2011 08:41:01 +0100
Message-ID: <4D3FD00D.2040303@yahoo.fr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D3DDDA4.2080202@yahoo.fr> <alpine.LFD.2.02.1101242154090.6097@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101242154090.6097@x980>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, rjw@sisk.pl, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

>>>>> * 2.6.35 series: .4 and .6 boot successfully, .8 and .10 fail;
>>>>> * 2.6.36 series: -rc2 boots successfully, .1 fails;
>>>>> * 2.6.37 series: -rc4 fails.
>>>>
>>>> So it's probably a commit to the mainline tree which was picked
>>>> by 2.6.35 maintainer to the stable tree (probably it was CC'ed)
>>>> cause this.
>>>>
>>>> Does passing nolapic or acpi=off cures the issue?
>>> IIRC, I tested at least one of these, without improvement.
>>> I'll test again tonight, when I can physically access the
>>> computer.
>> None of nolapic, acpi=off, nolapic acpi=off enables 2.6.35.8 to
>> boot on my ASUS F3Jv-AS022P.
>> The kernel line is
>> kernel /boot/vmlinuz root=/dev/sda9 nomce vga=791 nomodeset
>> I've attached the 2.6.35.6 config.
> 
> looks like you've bisected as far as:
> 2.6.35.6 good
> 2.6.35.8 bad
> 
> can you try 2.6.35.7 and continue on to find which specific patch
> in .stable broke your machine?
The bisection between 2.6.35.6 and 2.6.35.8 is in progress, two steps
left and no good kernel found yet (?!)
Due to not having physical access to the computer during work time, I
won't be able to finish until tonight.


Regards,
Lionel.
