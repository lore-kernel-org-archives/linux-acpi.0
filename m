From: Mattia Dongili <malattia@linux.it>
Subject: Re: ACPI Problems on Sony Vaio SZ61MN, no brightness ctrl, no power
	button
Date: Wed, 16 Jul 2008 20:27:08 +0900
Message-ID: <20080716112707.GA3777@inferi.kami.home>
References: <487CA418.6060103@uni-koblenz.de> <1216172299.1617.145.camel@rzhang-dt> <487DC015.6070704@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:35937
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752147AbYGPL5j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 07:57:39 -0400
Content-Disposition: inline
In-Reply-To: <487DC015.6070704@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Hey there,

sorry for being late... as usually happens recently.

On Wed, Jul 16, 2008 at 11:32:05AM +0200, Sebastian Pohl wrote:
> Hi!
...
>> Please file a new bug report for each of the problem (power button and
>> brightness) at http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>> and attach the files listed below. :)
>>
>>   
> Submitted both, after checking for existing, similar bugs :)
>
> http://bugzilla.kernel.org/show_bug.cgi?id=11095
> http://bugzilla.kernel.org/show_bug.cgi?id=11096
>> On Tue, 2008-07-15 at 15:20 +0200, Sebastian Pohl wrote:
>>   
>>> Hi there!
>>>
>>> First i hope my other messages have realy disappereard. I send them  
>>> yesterday from a windows machine and as described in the FAQ it 
>>> seemed to be blocked because of the charset. If by any chance that 
>>> message arrives please excuse it and ignore it!
>>>
>>> My Problem exists on a Sony Vaio Laptop with the modelcode SZ61MN/B. 
>>> I am currently running Archlinux with a 2.6.25.11-1 kernel. Most 
>>> things on the notebook seem to be working, even the lidswitch is 
>>> recognized.
>>>
>>> Problems are the non-working power button,
>>>     
>> what do you mean by non-working power button?
>> Pressing the power button doesn't power off the laptop, right?
>> what if you press it for four seconds?
>>
>> please run "grep . /sys/firmware/acpi/interrupts/*" both before and
>> after pressing the power button and attach the result.
>>
>>   
> Yes, youre right, pressing the button has no effect. Pressing 4 seconds  
> powers off the laptop. Is that done via acpi too? Thought that was a  
> hardwarething.
> Uploaded both outputs here:  
> http://www.twisted-artwork.de/vault/linux/powerbutton.txt

this is interesting, I never saw something like that for vaios and
linux.

>>>  thats a real problem, just annoying, and what realy is a pain, the 
>>> backlight brigthness is not adjustable, so i always get a nice suntan 
>>> from the screen. That realy sucks at night...
...
>>> I tried for about a week now to find a solution and i worked my way  
>>> through all of the possible solutions called sony-laptop, sonypi,  
>>> sony-acpi but none of them worked for me.
>>>     
>> what did you get?
>> empty /sys/class/backlight/ entry with any of these drivers loaded?
>> or the backlight I/F exists but they don't work for you?
>>
>>   
> The backlight files exist but they dont change anything. When i use the  
> sonypi driver
> i can change some of the stuff with the program spicctrl. Powering of  
> the internal devices
> works, adjusting fanspeed works, adjusting backlight just has no effects.

The SZ series have a stamina/speed switch switch between 2 video cards.
Usually one is an NVidia (for speed) and one is an Intel (for stamina).
On the NVidia there is nothing we can do (you can try nvclock or any
nvidia proprietary tool as documented on my wiki[1]), while for the
Intel card it's a different story (again documented on my wiki).
If you have no luck with the sony-laptop provided backlight control you
can try xbacklight that, as far as I can see[2], should work on your
Intel chipset.

hope this helps

[1]: http://www.linux.it/~malattia/wiki/index.php/Sony-laptop#Brightness
[2]: https://bugs.launchpad.net/ubuntu/+source/xbacklight/+bug/173652
-- 
mattia
:wq!
