From: Mike Perry <mikepery@fscked.org>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 13:45:09 -0600
Message-ID: <20070123194509.GA8644@fscked.org>
References: <20070123104010.GB7135@fscked.org> <20070123122925.GA27150@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sparky.fscked.org ([69.12.145.164]:55006 "EHLO fscked.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965408AbXAWTps (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 14:45:48 -0500
Received: from mikepery by fscked.org with local (Exim 4.43)
	id 1H9RZu-0003rL-0l
	for linux-acpi@vger.kernel.org; Tue, 23 Jan 2007 13:45:10 -0600
Content-Disposition: inline
In-Reply-To: <20070123122925.GA27150@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thus spake Pavel Troller (patrol@sinus.cz):

> > For some reason, on 2.6.17-2.6.19(+others?) the acpi_processor_idle
> > loop enabled by CONFIG_ACPI_PROCESSOR is causing my laptop's speakers
> > to buzz.. If the option is disabled or built as a module (or if I run
> > both my CPUs' usage up to 100%), the speakers are silent.
>
>   Your problem is related to hardware - poor filtering of power buses, causing
> current peaks to penetrate to the sound circuitry (or possibly causing some
> other hardware like a ferrite transformer) to emit sound.
>   By entering deeper sleep states (especially C3), power consumption of the
> CPU substantially reduces. By returning to C0, it increases again. These
> events happen periodically, thus causing a continuous wave to be produced.
>   When the system is not idle (working), the acpi CPU module is removed (so no
> sleeping) or USB is busy (so no C3, because of high BM activity), there is no
> reason for the sound.

Is there currently any way to disable busmastering or C3 transitions
(without recompilation)? Or better: is it possible to make the system
less eager to transition into C3 or otherwise reduce the frequency of
these transitions? If I could just get the frequency of transitions to
get out of the audible range, my life would be a lot better.

What governs the transition rate when the machine is mostly idle? Is
it the product of threshold.count and the latency, or am I misreading
this?

I'm sure I'm not the only person in the world who is going to
experience this problem, even if others haven't figured out what it is
yet. I'm willing to provide a patch for a proc or boot parameter-tuned
workaround if you can point me in the right direction. 

Please understand it really is quite annoying, and I doubt the
manufacturer is going to have any mercy because their Windows install
doesn't have the problem..


-- 
Mike Perry
Mad Computer Scientist
fscked.org evil labs
