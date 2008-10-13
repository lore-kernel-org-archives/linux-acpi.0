From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Mon, 13 Oct 2008 17:39:32 +0100
Message-ID: <48F379C4.9070105@tuffmail.co.uk>
References: <48F0DB0C.7060201@tuffmail.co.uk> <200810112140.16662.rjw@sisk.pl> <48F100CA.2050600@suse.de> <200810112254.09094.rjw@sisk.pl> <48F1BFD0.7040004@tuffmail.co.uk> <48F24EAE.6020108@suse.de> <48F30554.1010607@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:35024 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbYJMQjl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Oct 2008 12:39:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1730212fkq.5
        for <linux-acpi@vger.kernel.org>; Mon, 13 Oct 2008 09:39:37 -0700 (PDT)
In-Reply-To: <48F30554.1010607@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Alan Jenkins wrote:
> Alexis Starikovskiy wrote:
>   
>> Alan Jenkins wrote:
>>     
>>> Rafael J. Wysocki wrote:
>>>       
>>>> On Saturday, 11 of October 2008, Alexey Starikovskiy wrote:
>>>>  
>>>>         
>>>>> Rafael J. Wysocki wrote:
>>>>>    
>>>>>           
>>>>>>> No, we discussed this before -- we are outside of the
>>>>>>> transaction, thus no GPE
>>>>>>> activity could interfere with ec_check_ibf0.
>>>>>>>         
>>>>>>>               
>>>>>> Ok, this is in the process context and we don't really expect to
>>>>>> get an
>>>>>> interrupt at this point, but what happens if the EC generates an
>>>>>> event that's
>>>>>> not related to any transiaction.  Is that guaranteed to never happen?
>>>>>>       
>>>>>>             
>>>>> Interrupt handler in this case can't cause a change to status
>>>>> register, thus our read of it will not be affected by interrupt.
>>>>>     
>>>>>           
>>>> Ok, thanks.
>>>>
>>>> Alan, does the patch work for you?
>>>>
>>>> Rafael
>>>>   
>>>>         
>>> Yes.  Two reboot cycles, three suspend/resume cycles each, and no error
>>> message.
>>>
>>> I hope we have a better fix in mind though :-P.  The patch doesn't solve
>>> the unnecessary 500ms delay when this thing happens.
>>>       
>> Something like this?
>>
>> Regards,
>> Alex.
>>     
>
> You sent it as an attachment again :-).
>
> That should work, odd as it looks.  We don't need to worry about the GPE
> workaround because that's only active _inside_ the transaction.  I don't
> know what Zhao thinks is missing.
>
> Sorry I can't test right now.  I tried to install 3D support on my
> laptop for showing-off purposes, and somehow broke X.
>   
Drama over, I've now tested it.  No error messages, and the printk
timings show that it has stopped hanging for half a second.

Thanks
Alan
