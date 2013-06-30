From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: New motherboard not detecting all memory
Date: Sun, 30 Jun 2013 12:40:16 +0100
Message-ID: <51D01920.5080103@communistcode.co.uk>
References: <51CFF92C.8090404@communistcode.co.uk> <51D0090C.90402@communistcode.co.uk>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:57563 "EHLO owm.eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab3F3LkT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jun 2013 07:40:19 -0400
In-Reply-To: <51D0090C.90402@communistcode.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 30/06/2013 11:31, Jack Mitchell wrote:
> On 30/06/2013 10:23, Jack Mitchell wrote:
>> I recently bought a new AMD FM2 motherboard[1] and coupled it with an
>> AMD A4 APU. I put 2x2GB sticks of RAM in the board, and the UEFI bios
>> detects both sticks and reports 4GB. Now, when I boot into a fresh
>> install of Linux [2] only 1501MB is reported as available.
>>
>> I was told this may be an ACPI problem, I have updated the motherboard
>> to the latest BIOS revision which works. Could anyone shed any light on
>> this, or where I should make a start in helping to debug the problem?
>>
>> Kind Regards,
>> Jack.
>>
>> [1] http://www.gigabyte.com/products/product-page.aspx?pid=4383&dl=#ov
>> [2] Linux mediaserver 3.9.7-1-ARCH #1 SMP PREEMPT Thu Jun 20 22:45:32
>> CEST 2013 x86_64 GNU/Linux
>>
>>
>
> I have attached the dmidecode output in case that is of any help; I can
> see that it is only registering one bank of RAM, so detection of RAM
> seems to be the issue; but I don't know what is causing it.
>
> I have also attached a dmesg.
>
> Cheers,
> Jack.
>

Ok, I fiddled with the seating of the RAM and changing the slots; it 
appears that one of the sticks is bad, but the motherboard will still 
detect it in BIOS if it is coupled with the good stick. The bad stick on 
it's own will not even get to the BIOS 'initialization' screen.

Apologies for the noise.

Cheers,
Jack.

-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

-- 
