From: Niel Lambrechts <niel.lambrechts@gmail.com>
Subject: Re: BUG: blank screen - unless keyboard/synaptic combo
Date: Mon, 01 Jun 2009 07:08:40 +0200
Message-ID: <4A236258.4090004@gmail.com>
References: <4A12FCB2.6090409@gmail.com>  <4A15DC88.5070005@gmail.com>	 <1242963556.32574.59.camel@rzhang-dt>  <4A16EB0B.20205@gmail.com> <1243231091.32574.62.camel@rzhang-dt> <4A1A3C44.1060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4A1A3C44.1060503@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Niel Lambrechts wrote:
>>>>> c's added, attached lspci output.
>>>>>
>>>>> On 05/19/2009 08:38 PM, Niel Lambrechts wrote:
>>>>>
>>>>>         
>>>>>> I have a strange problem in that during a resume from hibernate my
>>>>>> text console (or X) remains blank - that is, until I simultaneously
>>>>>> press a keyboard key and touch the synaptic pad. It is not
>>>>>> sufficient
>>>>>> to press just one or the other, it needs to be done
>>>>>> simultaneously and
>>>>>> it resumes fine after doing this.
>>>>>>
>>>>>>            
>>>> is this a regression or it exists on all the kernel you've tried?
>>>>
>>>>        
>>> Hi Zhang,
>>>
>>> It is not a recent regression, all of the kernels I tried back to
>>> 2.6.28
>>> shows the same problem. The test results I posted last night was with
>>> 2.6.30-rc6. I suspect it did not happen in 2.6.27, but I might be wrong
>>> since I could not bisect that far back (I am using EXT4 and have too
>>> many issues to bisect that far back).
>>>
>>>     
>>>> please remote login the box after resume, and get the output of
>>>> "xrandr --verbose".
>>>>
>>>>        
>>> When I resume from suspend to RAM there is no problem.
>>>
>>> When I resume from hibernate, my laptop actually remains unusable until
>>> I do the combination of things I mentioned. I cannot log in from remote
>>> or even ping the laptop, except if I first press the mentioned key
>>> combo. Before this, the display is either entirely blank or sometimes
>>> there is a white cursor in the top left corner.
>>>
>>> The blank screen happens in runlevel 3 without X or "i915" loaded - I'm
>>> not sure but I suppose you want the "xrandr" output for another reason.
>>> It is interesting that it happens regardless of whether I am using
>>> Intel
>>> integrated graphics or Mobility Radeon HD 3650 (my laptop has both
>>> and I
>>> can enable one at a time). I boot the system with vga=791 and it is
>>> using vesafb for console.
>>>
>>> I attached the output you asked for below after hibernating an Xorg
>>> session, but this is from just after pressing the combo as I could not
>>> log in over the network with the laptop in the blank state.
>>>
>>> Thanks,
>>> Niel
Hi,

I've noticed that the screen only remains blank when I specify vga=xxx
(I normally use vga=791) as a boot option, in other words when using vesafb.

The blank screen on resume after hibernate consistently does not happen
if I boot without it, and I tested with kernels from 2.6.28.

Any idea who can help with this?

Regards,
Niel
