From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Put the Acer Aspire V5-471G on the use_native_backlight
 dmi list
Date: Fri, 02 May 2014 14:26:11 +0200
Message-ID: <53638EE3.9090001@redhat.com>
References: <1398865041-12071-1-git-send-email-hdegoede@redhat.com> <2332660.ry1qIif4gD@vostro.rjw.lan> <53635F3E.3080306@redhat.com> <2952273.ZKEyY9LbDD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26582 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbaEBM0T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 May 2014 08:26:19 -0400
In-Reply-To: <2952273.ZKEyY9LbDD@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org

Hi,

On 05/02/2014 01:58 PM, Rafael J. Wysocki wrote:
> On Friday, May 02, 2014 11:02:54 AM Hans de Goede wrote:
>> Hi,
>>
>> On 05/01/2014 10:10 PM, Rafael J. Wysocki wrote:
>>> On Thursday, May 01, 2014 12:38:28 PM Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 04/30/2014 09:52 PM, Rafael J. Wysocki wrote:
>>>>> On Wednesday, April 30, 2014 03:37:21 PM Hans de Goede wrote:
>>>>>> This fixes the backlight control not working.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>
>>>>> Sorry, this conflicts with commit 170269a9d3c0 (ACPI / video: Default to using
>>>>> native backlight control on Windows 8 systems) in linux-next, so I'm not going
>>>>> to apply it.
>>>>
>>>> I strongly disagree, rejecting bug-fixes which conflict with more rigorous
>>>> (and dangerous) fixes -next, purely because the conflict with something -next
>>>> is not a good reason. TBH I find it a complete non reason to reject these fixes.
>>>>
>>>>> If you wanted to have this stuff in 3.15, there was a plenty of time to submit
>>>>> it earlier.
>>>>
>>>> Heh, that assumes I was aware of this particular model needing this quirk earlier,
>>>> while I actually got the first report of it not working from Vincent on April 26th,
>>>> and got confirmation that the quirk fixes it on April 29th. I would say that 1 day
>>>> turn around time between getting the confirmation and sending the patch is not bad
>>>> at all.
>>>>
>>>> I really believe it is important to get the quirk for this model (and others) into
>>>> 3.15, here us my decision tree leading to this:
>>>>
>>>> -Do we want to fix these brightness issues -> Yes
>>>> -Do we expect our users to wait for 6 months for an upstream fix + many more months
>>>>  for the fixed kernel to hit distros -> No
>>>> -So we want to backport these fixes to stable -> Yes
>>>> -Is the proposed fix for 3.16 acceptable for stable -> No (too high change of
>>>>  regressions)
>>>
>>> OK, this is a good argument.
>>>
>>>> Conclusion: we want quirks for models known to need quirks added to 3.15 and
>>>> backported to the various stable series.
>>>>
>>>> I actually want to go as far as to claim that once 3.15 is released we will want
>>>> to add quirks to 3.15.x, breaking the every fix must be upstream rule for the stable
>>>> series. But lets safe that discussion for later.
>>>
>>> Well, there's a way out of this.  Instead of doing commit 170269a9d3c0 as is, we
>>> can just switch the default without removing the blacklist just yet.  And remove
>>> the blacklist one we are reasonably confident that the new default actually works.
>>>
>>> In which case I'd go for your original series (along with the RFC moving stuff
>>> out of blacklist.c to the video.c blacklist) with a replacement of commit
>>> 170269a9d3c0 that will simply flip the default.
>>>
>>> Does this make sense to you?
>>
>> Yes that seems like a good solution, thanks!
>>
>> I'll rebase and resend my RFC for moving the models from blacklist.c to video.c as non
>> RFC.
>>
>> Who is going to do the only flip the default version of 170269a9d3c0 ?
> 
> That would be either you or me I guess. :-)

I've already spend way too much time on backlight stuff lately, so if you could do it,
that would be great.

Regards,

Hans

p.s.

I've written a blog post about backlight brightness control, so that I've a
link with some basic background and a step-by-step guide for debugging to
put into future backlight bug reports:
http://hansdegoede.livejournal.com/13889.html

Feel free to use it for the same purpose, and comments / suggestions for
improving it are very much welcome.
