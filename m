From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Tue, 28 Oct 2008 20:18:07 +0000
Message-ID: <4907737F.6060507@tuffmail.co.uk>
References: <49071C33.7030308@tuffmail.co.uk> <4907590E.4070104@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:61127 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYJ1UQm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 16:16:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1065818nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2008 13:16:38 -0700 (PDT)
In-Reply-To: <4907590E.4070104@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
>> "plenty of line "ACPI: EC: non-query interrupt received,
>>  switching to interrupt mode" in dmesg"
> Probably, it is better to make pr_debug().

Yes, it seems useful to have when all the DEBUG output is enabled.

In that case, the initial message about starting in poll mode should 
also be switched to pr_debug().  Otherwise, the change will give the 
impression that the EC never switches to interrupt mode.

That just leaves the message "missing confirmations, switching to 
polling mode".  That should only happen once per boot, or after a 
suspend/resume cycle, right?  Because it sets NO_GPE, which inhibits 
GPE_MODE and is only reset on resume.  So that can be preserved, and 
it's probably a useful message to have.

I'll leave it to you to submit a more appropriate patch.

>>
>> GPE storm avoidance involves disabling the EC GPE during transactions.
>> Unfortunately we forget to re-enable EC_FLAGS_GPE_MODE afterwards.
> "We" don't forget it, "we" just use same mechanism as driver init. 
> Thus if
> for some reason interrupts do not start to arrive after we issue 
> enable_gpe(),
> we will not fall to timeouts.

Interesting.  I agree that sort of caution is meritted for the EC 
driver!  If that's by design, then great.

I will have a look at the code again for my own peace of mind; I thought 
I understood the GPE storm avoidance but now I'm a bit fuzzy on the 
details.  We apologize for the overuse of the third person.  After 
staring at the code for so long I have to identify with it to some 
extent, despite not having actually written any of it.

>>
>> This happens to work because we re-enable it anyway when we detect
>> the first confirmation interrupt of the next transaction.  However,
>> this causes lots of bogus "switching to interrupt mode" messages.
> they are not "bogus", it is really switching the mode...

Bad words.  It seems bogus because the message changes meaning - for me 
as _user_.  It used to be a gentle reassurance that my computer was 
booting or resuming it's way towards normal working state.  Now it has 
changed to a weaker meaning, because it can also mean that a new 
transaction started in GPE_STORM mode.

In the technical and literal sense the meaning is unchanged.  If the 
message is hidden under DEBUG, that is the only meaning that will matter :).

Thanks
Alan
