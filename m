From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Fri, 15 Dec 2006 08:41:27 -0500
Message-ID: <4582A607.8040302@gmail.com>
References: <457F37C0.3090003@gmail.com>	 <1165966936.29844.37.camel@pcjc2lap>  <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:32998 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbWLONlb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Dec 2006 08:41:31 -0500
Received: by wr-out-0506.google.com with SMTP id i7so591143wra
        for <linux-acpi@vger.kernel.org>; Fri, 15 Dec 2006 05:41:30 -0800 (PST)
In-Reply-To: <1166012707.22903.4.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org


> It was suggested to me to open a kernel bug (possibly starting under
> ACPI), however I never got to it.. I don't know where kernel bugs are
> reported officially, and was busy at the time. (still am). I do try and
> reply to others with the same problems though... finding the webpage
> which suggested that fix was not trivial!
>
> My lid switch is just above the keyboard, on the right hand side of the
> left hand screen hinge. It is just a tiny piece of plastic protruding
> from the case. Push it, and the screen goes off. Hold it, and wiggle the
> mouse (touchpad), and the naughty screen comes back on.
>
> Most importantly for me, the workaround brings the max CPU speed
> available with speed step back to what it is supposed to be on my
> laptop, and the BIOS actually boots much faster.
>
> Peter C.
>
>
>   

Well. I just tested the lid, and I don't seem to have that problem.
I also don't think I have an external lid-switch, because I really can't 
find it anywhere... anyway.

Your workaround got me past the buggy/slow booting; however, there's 
another problem that I've found that is just about as annoying. And I'm 
hoping that someone will have an idea.

When I boot the computer with ACPI support, there's an audible hum that 
comes from the CPU whenever the processor is idle.
This hum does not occur in windows, and when I boot with "noapic 
pci=noapic acpi=off" in the kernel options, the sound is gone.

Does anyone have any ideas how I can fix this? Is it possible to load 
ACPI as a module? Should I play around with which ACPI features are 
compiled in, and see which one, if it is just one, is the kicker?

Thanks again for all of your help,
Lincoln
