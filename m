From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Sat, 01 Nov 2008 11:03:13 +0000
Message-ID: <490C3771.7060207@tuffmail.co.uk>
References: <49071C33.7030308@tuffmail.co.uk> <4907590E.4070104@suse.de> <20081029001231.GA22985@khazad-dum.debian.net> <49083216.60202@tuffmail.co.uk> <20081029150836.GA31678@khazad-dum.debian.net> <490890EB.9090908@tuffmail.co.uk> <4908B2C4.8000903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:57091 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYKALEC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Nov 2008 07:04:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so711080nfc.21
        for <linux-acpi@vger.kernel.org>; Sat, 01 Nov 2008 04:03:16 -0700 (PDT)
In-Reply-To: <4908B2C4.8000903@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> Henrique de Moraes Holschuh wrote:
>>> On Wed, 29 Oct 2008, Alan Jenkins wrote:
>>>  
>>>> Henrique de Moraes Holschuh wrote:
>>>>    
>>>>> On Tue, 28 Oct 2008, Alexey Starikovskiy wrote:
>>>>>      
>>>>>> Alan Jenkins wrote:
>>>>>>        
>>>>>>> <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
>>>>>>> "plenty of line "ACPI: EC: non-query interrupt received,
>>>>>>>  switching to interrupt mode" in dmesg"
>>>>>>>                 
>>>>>> Probably, it is better to make pr_debug().
>>>>>>             
>>>>> Please don't do that.  This code has had a lot of churn, and
>>>>> *regressions*
>>>>> as of lately, and sometimes we only notice these because we see those
>>>>> messages in the logs.  Moving them to pr_debug() pretty much makes
>>>>> them
>>>>> utterly useless in a large number of the cases they could be of help.
>>>>>
>>>>> Besides, I very much doubt we will stop seing EC interrupt
>>>>> crappage. Not
>>>>> only our code is NOT good and resilient enough yet (if it were, there
>>>>> wouldn't be so many patches flying about it), the vendors are
>>>>> obviously
>>>>> getting this wrong at a fast rate.
>>>>>
>>>>> We need those messages.  Rate-limit them, but don't hide them or
>>>>> move them
>>>>> to pr_debug, please.
>>>>>       
>>>> Please have a look at the dmesg attached to the bug.  They're already
>>>> rate-limited.
>>>>     
>>> If people are considering moving it to pr_debug, it is not rate-limited
>>> enough (one per mode switch is not enough if the EC or the code is
>>> behaving
>>> so bad that it switches modes too often)...
>>>
>>>  
>>>> When in GPE storm avoidance mode, they will trigger once for each
>>>> transaction.  Transactions happen frequently, and will happen
>>>> continually once e.g. gnome-power-manager is polling the battery
>>>> level. In this special case, they're not a useful message to users or
>>>> blackbox-level testers; they are only useful as part of a full DEBUG
>>>> trace that actually shows the transactions.
>>>>     
>>> Well, if they move to pr_debug _only_ when in GPE storm avoidance
>>> mode, AND
>>> we get the logging of entering AND exiting GPE storm avoidance
>>> modes, that
>>> would be quite acceptable, I think.
>>>
>>>  
>>>> My original patch suppresses the message in this particular case,
>>>> but it
>>>> preserves it for the common non-storm case, where it may provide
>>>> useful
>>>> information.  And the message would still happen once on boot, before
>>>> the GPE storm is detected.  Unfortunately my patch also makes the
>>>> driver
>>>> a little less robust.  If the robustness issue can be addressed, do
>>>> you
>>>> accept that it's a good idea to suppress the flood of duplicate
>>>> messages
>>>> reported in this bug?
>>>>     
>>> As I said above, if you supress them ONLY during GPE storm
>>> avoidance, then
>>> yes, I am quite OK with it.
>>>
>>> But we really should have GPE storm avoidance events logged, if we
>>> don't do
>>> that already.
>>>
>>>  
>>>> We already have... damn.  I think you missed a more important
>>>> omission. There _used_ to be a message that says we've switched to
>>>> storm avoidance
>>>> mode.  However, it was removed in the latest re-write.  This bug
>>>> report
>>>> suggests that a) the cause would have been more obvious if we had the
>>>> GPE storm message, and b) the stormy case wasn't really tested so we
>>>> really do need a message, in case it goes wrong.
>>>>     
>>> Indeed, that's bad, and needs to be fixed IMHO.
>>>   
>>
>> Alex, can we persuade you?  Here are the two changes in code form
>> (untested).
> Well, I was the one who inserted all this printouts in the first place...
> Then every second reader of dmesg, and there are quite a lot of those
> starts to
> open a bug report -- "my system prints bla-bla"...
> So, if there is demand to have this printed -- there is no objection
> from me.

To be fair, some of those reports were from people whose hardware used
to work, and was then degraded by the old polling code.  I.e. laggy /
jerky brightness hotkeys, which are rather noticable, especially with
auto-repeat.  It wasn't the _message_ that they were complaining about :).

Sorry for the delay, I had to test the code first!  I set
ACPI_EC_STORM_THRESHOLD to zero to get the storm avoidance to trigger on
my hardware.  I had to apply on top of the acpi-test tree, i.e. the
msleep()->udelay() patch, otherwise the storm avoidance kills the EC. 
After that, I could see the flood of messages.  My patch got rid of the
message flood, as expected.

Alan
