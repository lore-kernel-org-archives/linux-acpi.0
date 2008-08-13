From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other GPEs)
 on Asus EeePC
Date: Wed, 13 Aug 2008 15:39:00 +0100
Message-ID: <48A2F204.2050407@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk> <20080813034628.0ef51866.akpm@linux-foundation.org> <48A2CAAA.7010405@tuffmail.co.uk> <200808131536.57705.maxi@daemonizer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:39938 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbYHMOjF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2008 10:39:05 -0400
Received: by ik-out-1112.google.com with SMTP id c28so12712ika.5
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2008 07:39:03 -0700 (PDT)
In-Reply-To: <200808131536.57705.maxi@daemonizer.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maximilian Engelhardt <maxi@daemonizer.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@hmh.eng.br, stable@kernel.org

Maximilian Engelhardt wrote:
> On Wednesday 13 August 2008, Alan Jenkins wrote:
>   
>> [Dupe apology: CC'd to stable@kernel.org, with the right address this time]
>>
>> Andrew Morton wrote:
>>     
>>> On Wed, 13 Aug 2008 11:21:10 +0100 Alan Jenkins 
>>>       
> <alan-jenkins@tuffmail.co.uk> wrote:
>   
>>>> Andrew Morton wrote:
>>>>         
>>>>> Did this get fixed yet?
>>>>>
>>>>> I have an patch in -mm which I just restored (I had to tempdrop it
>>>>> because the acpi tree was busted for some time).  But it seems to be
>>>>> old.
>>>>>
>>>>> http://bugzilla.kernel.org/show_bug.cgi?id=10919 is marked "resolved"
>>>>> but the reporter (Maximilian) seems to think otherwise.  2.6.26.x is,
>>>>> afaik, still unfixed, as is 2.6.27-rc.
>>>>>           
>>>> That's correct.  I think this specific patch should go in 2.6.27 and
>>>> 2.6.26-stable.  No objections have been raised so far.
>>>>
>>>> I still need this patch to make my brightness and volume control keys
>>>> usable in 2.6.27-rc3.  (They auto-repeat fast enough to trigger the
>>>> bug).  This is true even after applying the latest patches from bug
>>>> 10919 (#25 + #27).
>>>>         
>>> Confusing.  Please send the patch which you think we should apply.
>>>
>>>       
>>>> I think the 10919 fix makes it harder to reproduce, but it definitely
>>>> still happens.  I guess this is because the polling-driven EC
>>>> transactions add 1ms delays between each byte.  The slower timings leave
>>>> a window where the buggy behaviour of my EC can make a difference.  (It
>>>> has been seen to clear the "pending event" bit after a single event is
>>>> read, despite having more events pending).
>>>>
>>>> There are more serious consequences of this bug.  After a while it can
>>>> confuse the EC enough to cause lockups or reboots during boot, or after
>>>> pressing a single hotkey.  This bad state is preserved over reboots,
>>>> even into known good kernels.  Fortunately the badness clears when power
>>>> is removed for a long enough period.  For a while I was worried that
>>>> something had physically burnt out.
>>>>         
>>> Oh gad.  And there's no workaround?
>>>       
>> Sorry, that was confusing.
>>
>> The patch in currently in -mm _is_ the workaround for this damage.  It
>> was not initially obvious just how important it was :-).  I've
>> re-attached it as requested.
>>
>> 10919, "laggy hotkeys" is just what it says; ACPI EC events are slower
>> because of polling.  It appears to be a more cosmetic issue which is
>> orthogonal to the _dropping_ of events.
>>
>> Thanks
>> Alan
>>     
>
> This patch doesn't fix my problem (bug 10919), it only changes it a bit.
> When I press the dimming key and hold it pressed the display should dim 
> up/down step by step as long as I hold the key pressed (that's how it has 
> always been).
> I'm now running a 2.6.27-rc3 kernel with your patch applied and the display 
> does dim as described below.
> When I press the dimming key first the display brightness doesn't change at 
> all, then it jumps multiple steps, stays there for a short while and again 
> jumps some steps till it reaches the end of the dimming interval.
> It looks like the key presses (assuming holding down the key does generate 
> multiple key presses) get queued up, then all processed all at once, then 
> again queued up...
>
> Maxi
>   
This is expected behaviour - I can explain it in detail if that helps. 
I see the same on my laptop, though perhaps it is more annoying on yours.

The patch I've submitted here is not intended to fix #10919.  You said
the patch at <http://bugzilla.kernel.org/show_bug.cgi?id=10919#c21>
worked for you, and I think the approach there is the way forward for
this "laggy" issue.  However I don't know if it will be ready for this
kernel release.  I pointed out a cosmetic issue with it to Alexey but
haven't heard anything since.

Alan
