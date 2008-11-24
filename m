From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: battery: current a factor of 10 off? [fix confirmed]
Date: Mon, 24 Nov 2008 10:44:36 +0300
Message-ID: <492A5B64.1080306@gmail.com>
References: <87skplx6ho.fsf@szonett.ki.iif.hu>	<8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>	<4926C87D.20308@gmail.com> <878wr9j3v9.fsf_-_@szonett.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:10038 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYKXHoj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Nov 2008 02:44:39 -0500
Received: by ug-out-1314.google.com with SMTP id 39so655240ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 23 Nov 2008 23:44:37 -0800 (PST)
In-Reply-To: <878wr9j3v9.fsf_-_@szonett.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org

Ferenc Wagner wrote:
> Alexey Starikovskiy <aystarik@gmail.com> writes:
>
>   
>> Alexey Starikovskiy wrote:
>>
>>     
>>> On Fri, Nov 21, 2008 at 3:33 AM, Ferenc Wagner <wferi@niif.hu> wrote:
>>>
>>>       
>>>> on my ThinkPad R50e the current_now reading seems something like 10
>>>> times the actual value.  [...]
>>>>         
>>> Good catch.  ACPI battery interface report its state either in mW
>>> or in mA, and discharge rate in your case is reported in
>>> mW. power_supply interface does not have such a parameter, so
>>> current_now parameter is used for all cases. But in case of mW,
>>> reported discharge should be converted into mA.
>>>
>>> Please test the attached patch.
>>>       
>> This patch should be better -- no integer overflow.
>>     
>
> Hi Alex,
>
> Thanks, this patch really fixes the issue (tried on 2.6.28-rc6).
> Hope to see it soon in Linus' tree!
>   
Great! Do you want to be memorized by "Tested-by:" line?
> Btw. that kernel gives me two ACPI warnings on boot:
>
>   ACPI: RSDP 000F6E40, 0024 (r2 IBM   )
>   ACPI: XSDT 1F6EF33D, 004C (r1 IBM    TP-1W        2060  LTP        0)
>   ACPI: FACP 1F6EF400, 00F4 (r3 IBM    TP-1W        2060 IBM         1)
>   ACPI Warning (tbfadt-0460): Optional field "Gpe1Block" has zero address or length: 000000000000102C/0 [20080926]
>   
Almost all machines produce this... Spec defines 2 GPE blocks as 
default, so we complain if only one is used, but that happens quite 
often...
>   ACPI: DSDT 1F6EF5E7, 7865 (r1 IBM    TP-1W        2060 MSFT  100000E)
>   ACPI: FACS 1F6F8000, 0040
>   ACPI: SSDT 1F6EF5B4, 0033 (r1 IBM    TP-1W        2060 MSFT  100000E)
>   ACPI: ECDT 1F6F6E4C, 0052 (r1 IBM    TP-1W        2060 IBM         1)
>   ACPI: TCPA 1F6F6E9E, 0032 (r1 IBM    TP-1W        2060 PTL         1)
>   ACPI: BOOT 1F6F6FD8, 0028 (r1 IBM    TP-1W        2060  LTP        1)
>   [...]
>   ACPI Warning (nspredef-0858): \_SB_.PCI0.LPC_.EC__.BAT0._BIF: Return Package type mismatch at index 9 - found Buffer, expected String [20080926]
>   
This one also could be treated as false positive -- spec says it should 
be string, but almost all BIOS implementations return buffer here.
>   ACPI: Battery Slot [BAT0] (battery present)
>
> I'm willing to provide further info if anybody here is interested.
>   

These issues are already known, and second even has a patch lurking 
somewhere in this list... So no action required.

Thanks again,
Alex.
