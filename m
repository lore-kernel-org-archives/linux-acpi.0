From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop rfkill, stupid question #4 and 5
Date: Fri, 31 Oct 2008 20:54:59 +0000
Message-ID: <490B70A3.8010108@tuffmail.co.uk>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <490B4014.4040009@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:13970 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbYJaUzF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 16:55:05 -0400
In-Reply-To: <490B4014.4040009@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins wrote:
> Matthew Garrett wrote:
>   
>> On Fri, Oct 31, 2008 at 05:09:09PM +0000, Alan Jenkins wrote:
>>   
>>     
>>> Did you miss a call to rfkill_force_state() on resume?
>>>     
>>>       
>> Conceivably. I didn't test the hibernation case.
>>
>>   
>>     
>>> Actually, normal boot doesn't preserve the setting either.  Your commit
>>> changes the behaviour from the rfkill state being persistent across
>>> reboot / power off (as a bios setting), to being always enabled on
>>> boot.  It seems like a bad idea to me.
>>>     
>>>       
>> This is the behaviour of the rfkill core.
>>   
>>     
> Documentation/rfkill.txt implied otherwise
>
>     You should:
>         - rfkill_allocate()
>         - modify rfkill fields (flags, name)
>         - modify state to the current hardware state (THIS IS THE ONLY TIME
>           YOU CAN ACCESS state DIRECTLY)
>         - rfkill_register()
>
>
> Admittedly it doesn't say "and I promise not to gratuitously override
> the state on registration".  Buti t seems weird though, to override the
> value on registration 
Ah, I see.  Wrong end - of course the *rfkill device* doesn't have
useful state.  The persistent state belongs to the *rfkill switch* - it
could even be a physical switch.

And now it's clear what was missing from the conversion to rfkill:

    2. Input device switches (sources of EV_SW events) DO store their
    current state
    (so you *must* initialize it by issuing a gratuitous input layer
    event on
    driver start-up and also when resuming from sleep)

Regards
Alan
