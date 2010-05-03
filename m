From: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting them
Date: Mon, 03 May 2010 07:45:04 -0400
Message-ID: <4BDEB740.4090703@myrealbox.com>
References: <1272062884.1594.73.camel@laptop>	 <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>	 <20100424211601.GA16731@srcf.ucam.org> <1272154774.1839.365.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 207-172-69-77.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.69.77]:33274
	"EHLO thaum.luto.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757634Ab0ECLpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 07:45:09 -0400
In-Reply-To: <1272154774.1839.365.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

Jerone Young wrote:
> On Sat, 2010-04-24 at 22:16 +0100, Matthew Garrett wrote:
>> On Sat, Apr 24, 2010 at 03:49:38PM -0500, Jerone Young wrote:
>>
>>> The issue is the way Windows does it is through a userspace daemon.  By
>>> making it OSI=Linux (just as with the Thinkpads currently already in
>>> blacklist.c ..*61 line) the machines just send the OS a key press.
>> And how does that userspace daemon receive the event?
>>
>>> Since newer thinkpads as well as most other OEM machines take this
>>> model. It provides a much better user experience then what it is like
>>> today.
>> It's a model-specific quirk in generic code, so it's massively desirable 
>> to avoid this especially since it encourages other OEMs to do the same 
>> kind of thing.
> 
> Also to mention Matt that this is already done in the code for the *61
> line, T400, T500, R400. All of these are from the same production time
> period. Please see drivers/acpi/blacklist.c. 
> 
> These machines will not change and are not getting BIOS updates to
> change. They have finished there production run.
> 
> It may be just me. But I'm failing to see why this is a big deal. If the
> others where put in to fix them, newer Thinkpad models have stopped
> this behavior, and these Thinkpads will not be getting updated. Users
> with these models are going to have a bad experience when it comes to
> muting.
> 
> I personally use an X301. I would put that in as well, but there is a
> little light on it.. that none of the models in the patch have. That
> lets you know the hardware mute is on, I've seen some people really like
> that (had a proposed patch in last Ubuntu release and got bugs
> saying...What happened to my mute light!!).

[warning: I don't understand ALSA *at all*.]  How hard would it be for 
the kernel to report the extra Thinkpad mixer as *part* of the main 
sound card?  Something though a platform driver and a hook in hda_intel 
or its codecs, maybe?  The X301 mute light could work the same way (have 
the sound driver notify the ACPI driver that the master mixer is muted 
and then turn on the light, or use a tiny userspace daemon to do exactly 
the same thing).

It seems rather overcomplicated to implement either a second mixer or 
some special-purpose thinkpad_acpi driver and then hack userspace to 
understand that the kernel is unable to report sanely what the hardware 
actually does.

OTOH, OSI(Linux) already makes the hardware work sensibly, and the user 
experience on Windows is ugly enough that I don't see any good reason to 
emulate it.

--Andy
