From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si
 2636
Date: Wed, 08 Oct 2008 15:52:43 +0400
Message-ID: <48EC9F0B.3090207@gmail.com>
References: <48E9F51A.4080107@gmail.com> <48EC7430.1010001@gmail.com> <48EC9004.6010105@gmail.com> <200810081308.52221.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:37243 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbYJHLw2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 07:52:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1538051nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2008 04:52:23 -0700 (PDT)
In-Reply-To: <200810081308.52221.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Lindroth <thomas.lindroth@gmail.com>, linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Wednesday 08 October 2008 12:48:36 Thomas Lindroth wrote:
>   
>> Alexey Starikovskiy wrote:
>>     
>>> Alexey Starikovskiy wrote:
>>>       
>>>> This is AML implementation of EC driver... it relies on certain speed
>>>> of AML interpreter to work properly (look for Noop inserted as delay).
>>>>
>>>> It is possible to replace this driver with the native Linux one, which
>>>> might be
>>>> more robust, but this involves heavy DSDT hacking.
>>>>
>>>> Overall, it is heavily mis-designed BIOS, so don't expect it to be
>>>> fixed on Linux side.
>>>>
>>>> Regards,
>>>> Alex.
>>>>         
>>> Please check if making Noop a small delay helps
>>>       
>> I've tried the patch with an udelay of 100 but it did not make any
>> difference. I've also tried raising it to 200 but that created an
>> unbootable system because one of the ACPI init methods failed.
>>
>> You are right, this is a really broken BIOS.
>>
>> I find it odd that only I experience this problem. According to one
>> site this laptop is the 7:th most popular laptop right now so someone
>> else should have reported something.
>>     
T7 is not very popular setting :)
> Could you provide a short explanation what should be fixed in which way in the 
> BIOS tables. Best in a way that I can just forward this.
> It's hard in the laptop area to convince fsc to fix it, but I at least like to 
> try and to tell them.
> Hmm, I think the last two mails should already be enough, I think  I got it.
>
>   
As I understand, this is not FSC, but FIC outsource. There is exactly
same thing happening in new FIC laptop.
> Is there a general hint I could add into the ACPI Linux guideline, like:
> Don't implement EC data/index register reads/writes in AML yourself.
> Define a EC variable and e.g. use Store(ECXY, Local0) to read and
> Store(Local0, ECXY) to write to specific EC bytes.
>
>   
Declare EC interface might be a better wording.
> Did I get this right?
>
>   
Yes.
My understanding is that Windows does not support 2 EC devices, so
these people need to implement second in AML.
So, it might be worth noting that Linux can handle any number of EC devices.


Regards,
Alex.
