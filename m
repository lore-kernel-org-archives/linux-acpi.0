From: Sebastian Pohl <sebastianp@uni-koblenz.de>
Subject: Re: ACPI Problems on Sony Vaio SZ61MN, no brightness ctrl, no	power
 button
Date: Wed, 16 Jul 2008 11:32:05 +0200
Message-ID: <487DC015.6070704@uni-koblenz.de>
References: <487CA418.6060103@uni-koblenz.de> <1216172299.1617.145.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deliver.uni-koblenz.de ([141.26.64.15]:14220 "EHLO
	deliver.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbYGPJcI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2008 05:32:08 -0400
In-Reply-To: <1216172299.1617.145.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

Hi!

Thanks for your answer!

Zhang Rui wrote:
> Hi, Sebastian,
>
> Please file a new bug report for each of the problem (power button and
> brightness) at http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and attach the files listed below. :)
>
>   
Submitted both, after checking for existing, similar bugs :)

http://bugzilla.kernel.org/show_bug.cgi?id=11095
http://bugzilla.kernel.org/show_bug.cgi?id=11096
> On Tue, 2008-07-15 at 15:20 +0200, Sebastian Pohl wrote:
>   
>> Hi there!
>>
>> First i hope my other messages have realy disappereard. I send them 
>> yesterday from a windows machine and as described in the FAQ it seemed 
>> to be blocked because of the charset. If by any chance that message 
>> arrives please excuse it and ignore it!
>>
>> My Problem exists on a Sony Vaio Laptop with the modelcode SZ61MN/B. I 
>> am currently running Archlinux with a 2.6.25.11-1 kernel. Most things on 
>> the notebook seem to be working, even the lidswitch is recognized.
>>
>> Problems are the non-working power button,
>>     
> what do you mean by non-working power button?
> Pressing the power button doesn't power off the laptop, right?
> what if you press it for four seconds?
>
> please run "grep . /sys/firmware/acpi/interrupts/*" both before and
> after pressing the power button and attach the result.
>
>   
Yes, youre right, pressing the button has no effect. Pressing 4 seconds 
powers off the laptop. Is that done via acpi too? Thought that was a 
hardwarething.
Uploaded both outputs here: 
http://www.twisted-artwork.de/vault/linux/powerbutton.txt
>>  thats a real problem, just 
>> annoying, and what realy is a pain, the backlight brigthness is not 
>> adjustable, so i always get a nice suntan from the screen. That realy 
>> sucks at night...
>>     
> please attach the acpidump output with the latest pmtools at
> http://www.lesswatts.org/patches/linux_acpi/
>   
As i am not sure if its wise to paste it here, i just uploaded it to my 
webspace, its quite a long file.
(And as i remember attachments on emails are not allowed on mailing lists?)
The URL is http://www.twisted-artwork.de/vault/linux/acpidump.txt
>   
>> I tried for about a week now to find a solution and i worked my way 
>> through all of the possible solutions called sony-laptop, sonypi, 
>> sony-acpi but none of them worked for me.
>>     
> what did you get?
> empty /sys/class/backlight/ entry with any of these drivers loaded?
> or the backlight I/F exists but they don't work for you?
>
>   
The backlight files exist but they dont change anything. When i use the 
sonypi driver
i can change some of the stuff with the program spicctrl. Powering of 
the internal devices
works, adjusting fanspeed works, adjusting backlight just has no effects.
> cc Mattia, who is the maintainer of sony-laptop driver. :)
>
>   
Did that too a few days ago, but got no answer, maybe i got the wrong 
adress.


Thanks for your help, i hope it doesnt take too long to solve this, 
cause in the meantime i am forced to use Windows when i am on the road, 
caus it has nearly twice the runtime on battery... :)

regards

      sebastian
