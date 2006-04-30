From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [discuss] [RFC] make PC Speaker driver work on x86-64
Date: Sun, 30 Apr 2006 17:29:32 +0100
Message-ID: <200604301729.32008.s0348365@sms.ed.ac.uk>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301046.22369.ak@suse.de> <878xpnt9ps.fsf@informatik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.bulldogdsl.com ([212.158.248.7]:37131 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751160AbWD3Q3Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Apr 2006 12:29:24 -0400
In-Reply-To: <878xpnt9ps.fsf@informatik.uni-tuebingen.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Mikael Pettersson <mikpe@it.uu.se>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday 30 April 2006 15:32, Goswin von Brederlow wrote:
> Andi Kleen <ak@suse.de> writes:
> > On Saturday 29 April 2006 20:30, Mikael Pettersson wrote:
> >> I have a pair of Athlon64 machines that dual-boot 32-bit and
> >> 64-bit kernels. One annoying difference between the kernels
> >> is that the PC Speaker driver (CONFIG_INPUT_PCSPKR=y) only
> >> works in the 32-bit kernels.
> >
> > Ah, I would consider this more a feature than a bug but ok :)
> >
> >> In the 64-bit kernels it remains
> >> inactive and doesn't even generate any boot-time initialisation
> >> or error messages.
>
> That means that the system wouldn't beep on the console or when you
> call "beep", right?
>
> With 2.6.8 x86_64 that worked without problems. Since I updated to
> 2.6.15 the system is silent.
>
> Could it be that this is a recent problem?

I think it's as described; the pcspkr driver changed in design around this 
time and needs to be plugged, now. It's probably exactly the same issue.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
