From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Thu, 26 Nov 2009 01:00:44 -0500
Message-ID: <cb0375e10911252200t2e4eb852q88d3b9015a75c071@mail.gmail.com>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
	 <1259170225.4391.4.camel@laptop>
	 <alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
	 <20091126050748.GA7874@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42581 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbZKZGAj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 01:00:39 -0500
Received: by fxm5 with SMTP id 5so408706fxm.28
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2009 22:00:44 -0800 (PST)
In-Reply-To: <20091126050748.GA7874@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Jerone Young <jerone.young@canonical.com>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Nov 26, 2009 at 12:07 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Nov 25, 2009 at 01:24:50PM -0500, Len Brown wrote:
>
>> Have these been verified as necessary to make sound work on
>> the specified models, or are these speculative patches?
>
> To clarify - these patches do *nothing* to make sound work. They change
> the behaviour of the mute key from changing the hardware state of the
> mixer and not sending a key event to instead sending a key event and
> requring that software perform the change. The behavioural change is
> primarily cosmetic rather than functional. I'm not convinced that this
> is a sensible thing to do at this point in the release cycle, given that
> we have no testing of what other behavioural changes the firmware may
> make.

It's a functional change in the sense that the mixer is not usefully
supported right now (it's a file in /proc/acpi/ibm which is
nonstandard and which no one should reasonably be expected to know
about), it's useless (the standard HDA mixer works just fine), and
without this change the mute button breaks sound for everyone except
power users (who else is supposed to know to twiddle
/proc/acpi/ibm/volume or press "sound up" to get sound back when the
ALSA controls are already unmuted and set to maximum volume).

I'll grant that, with this change, Linux works differently from
Windows, but I'm not sure that's a good argument for leaving this
change out.  IMO in an ideal world, Lenovo would stop looking at
OSI(Linux) and would also eliminate their weird mixer interface
completely.  At least with this change we can continue ignoring the
weird mixer interface until we have proper ALSA integration.

--Andy
