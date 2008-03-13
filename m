From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Thu, 13 Mar 2008 17:52:05 +0300
Message-ID: <47D93F95.50807@gmail.com>
References: <20080312193637.GA27873@ics.muni.cz> <20080312211306.GD30864@khazad-dum.debian.net> <20080313120514.GH17940@kernel.dk> <20080313122344.GD27873@ics.muni.cz> <20080313124633.GS17940@kernel.dk> <20080313125503.GE27873@ics.muni.cz> <20080313125933.GT17940@kernel.dk> <20080313130934.GG27873@ics.muni.cz> <20080313131334.GV17940@kernel.dk> <47D93C2C.8040907@gmail.com> <20080313143930.GZ17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:36452 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYCMOwN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Mar 2008 10:52:13 -0400
Received: by fk-out-0910.google.com with SMTP id z23so3400280fkz.5
        for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2008 07:52:11 -0700 (PDT)
In-Reply-To: <20080313143930.GZ17940@kernel.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Arkadiusz Miskiewicz <arekm@maven.pl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Jens Axboe wrote:
> On Thu, Mar 13 2008, Alexey Starikovskiy wrote:
>   
>> Jens Axboe wrote:
>>     
>>> On Thu, Mar 13 2008, Lukas Hejtmanek wrote:
>>>  
>>>       
>>>> On Thu, Mar 13, 2008 at 01:59:34PM +0100, Jens Axboe wrote:
>>>>    
>>>>         
>>>>> The BIOS isn't that old, probably updated it a couple of months ago.
>>>>>      
>>>>>           
>>>> I use the latest BIOS for my T61 and it just works. At least the event is
>>>> generated either for acpid or for Xserver.
>>>>    
>>>>         
>>> This is an x60, so there may be other differences there.
>>>
>>>  
>>>       
>> There are was some playing with acpi_osi=Linux in this timeframe, known
>> to deal with sound buttons too.
>> Some of Thinkpads were inserted into the blacklist to need this OSI.
>> It might be that your Thinkpad needs it too...
>>     
>
> Please talk to me like I'm an ACPI ignorant - because I am. Where is
> this blacklist?
>
>   
drivers/acpi/blacklist.c:485.
You probably could set acp_osi=Linux as kernel parameter to check if it 
helps.
