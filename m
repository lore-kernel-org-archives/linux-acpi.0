From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Sun, 12 Oct 2008 10:13:52 +0100
Message-ID: <48F1BFD0.7040004@tuffmail.co.uk>
References: <48F0DB0C.7060201@tuffmail.co.uk> <200810112140.16662.rjw@sisk.pl> <48F100CA.2050600@suse.de> <200810112254.09094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:18532 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYJLJN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Oct 2008 05:13:57 -0400
Received: by nf-out-0910.google.com with SMTP id d3so529074nfc.21
        for <linux-acpi@vger.kernel.org>; Sun, 12 Oct 2008 02:13:55 -0700 (PDT)
In-Reply-To: <200810112254.09094.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
> On Saturday, 11 of October 2008, Alexey Starikovskiy wrote:
>   
>> Rafael J. Wysocki wrote:
>>     
>>>> No, we discussed this before -- we are outside of the transaction, thus 
>>>> no GPE
>>>> activity could interfere with ec_check_ibf0.
>>>>         
>>> Ok, this is in the process context and we don't really expect to get an
>>> interrupt at this point, but what happens if the EC generates an event that's
>>> not related to any transiaction.  Is that guaranteed to never happen?
>>>       
>> Interrupt handler in this case can't cause a change to status register, thus our 
>> read of it will not be affected by interrupt.
>>     
>
> Ok, thanks.
>
> Alan, does the patch work for you?
>
> Rafael
>   

Yes.  Two reboot cycles, three suspend/resume cycles each, and no error
message.

I hope we have a better fix in mind though :-P.  The patch doesn't solve
the unnecessary 500ms delay when this thing happens.

Thanks
Alan
