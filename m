From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: Re: experimental patch for toshiba_acpi
Date: Thu, 26 Feb 2009 00:22:29 +0000
Message-ID: <49A5E0C5.8090700@buzzard.me.uk>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk> <20090225165152.GA5981@srcf.ucam.org> <1235581978.4770.77.camel@penguin.lifesci.dundee.ac.uk> <20090225172835.GA7152@srcf.ucam.org> <1235584419.4770.86.camel@penguin.lifesci.dundee.ac.uk> <20090225175923.GB7836@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:45750 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071AbZBZAc3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 19:32:29 -0500
In-Reply-To: <20090225175923.GB7836@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

Matthew Garrett wrote:
> On Wed, Feb 25, 2009 at 05:53:39PM +0000, Jonathan Buzzard wrote:
>> On Wed, 2009-02-25 at 17:28 +0000, Matthew Garrett wrote:
>>> The same argument encourages us to put rfkill and brightness control 
>>> support in a userland tool, despite the existing kernel interfaces for 
>>> controlling them. We could replace almost every driver in platform/x86 
>>> with a generic driver that allowed arbitrary ACPI methods to be called 
>>> and gave access to EC bits. The reason we haven't done this is because 
>>> that's what the kernel is there for.
>> Quite correct they should be removed. The first step of which is to
>> provide a generic interface to the HCI.
> 
> Yeah. No.

Yeah, yes

> 
>> You do it, test it then maintain it then. To claim that maintaining this
>> in kernel space is as easy as users space is patently ludicrous.
> 
> How so? C is C. Whether you do it in userspace or kernel space, all you 
> have to do is make a function call with the appropriate arguments.
>

No it is not. C that is running in kernel space is not the same as C 
that is runing in user space. The potential for a bug to have security 
implications is *far* higher. If you start pushing hundreds of lines of 
string parsing into the kernel that just got a whole lot more likely.

Then one has to go through the whole rigmarole of submitting patches to 
various kernel developers and hoping that it gets in the next kernel. As 
opposed to releasing your own user land code, that might not even be in 
C, it could be C++, Perl, Python whatever takes your fancy when ever it 
takes your fancy.

Finally I speak from actual experience on this matter. The very early 
versions of the toshiba drive did everything via a proc interface. It 
sucked, was buggy and hundreds of lines long. I then stripped it down 
wrote a wrapper to the HCI, reduced the amount of kernel code by an 
order of magnitude.

>> A "proper" kernel driver as you put it is is completely inappropriate.
>> You want to unnecessarily pollute the kernel with hundreds of lines of
>> code for no actual gain in functionality.
> 
> Yes. I want a proper kernel driver.
> 

Well write it yourself, because I certainly am not. In the meantime 
there is perfectly good method that allows lots of existing code to just 
work. The only thing I am likely to do is update the toshiba driver so 
it detects whether ACPI is enabled and uses ACPI methods if that is the 
case.

I would be interested in what on earth makes you thing putting hundreds 
of lines of code into a "proper" kernel driver as you put it is better 
as it is simply not the Unix way.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Fife, United Kingdom.
