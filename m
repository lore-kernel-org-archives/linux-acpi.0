From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Sat, 18 Nov 2006 09:12:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611180912090.3618@woody.osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755204AbWKRRTL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Nov 2006 12:19:11 -0500
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC5AD47B@mssmsx411>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org


On Sat, 18 Nov 2006, Starikovskiy, Alexey Y wrote:
>
> May because it does not have a single common line with the previous
> patch?

Yeah, I do agree that it _looks_ very different as a patch, but it ends up 
having all the same execution profiles..

It's been too long since I debugged the previous problem, so I don't 
remember the exact details any more (back then I enabled ACPI debugging 
and watched the messages scroll by etc - this time I initially thought it 
was interrupt-related due to the other irq problems we've had, so I 
started bisecting immediately _without_ doing any ACPI debugging stuff, 
and by the time I actually bisected down enough, I recognized the problem, 
so I didn't do all the same "enable ACPI messages and look deeply into 
what is going on" thing).

But if I remember correctly, what happens is _roughly_ something like 
this:

 - thermal event happens - the CPU is getting warm, and the fan needs to 
   start up. Quite often, this happened early during boot (which is quite 
   busy - some init scripts are disgustingly CPU-intensive mainly due to 
   using inefficient scripting languages), but if it didn't happen there, 
   it's easy enough to force to happen other ways.

 - part of the handling is "acpi_os_execute()" for something (don't ask me 
   what), but the interestign thing is how that "acpi_os_execue()" then 
   ends up causing a _recursive_ event.

 - we handle the original event in kacpid, and hand over the new one as a 
   notification event. But the event keeps on happening, and kacpid keeps 
   on running, and the other thread doesn't actually ever _run_ because 
   kacpid holds he ACPI lock and is constantly busy.

 - we not only are constantly running in kernel space, we also end up 
   eventually running out of memory for allocating all the work queue 
   entries.

So the reason the old code works is because everything is done in a single 
thread, and yes, we end up getting multiple events, but because the queue 
is all done onto the same queue that is _handling_ the events in the first 
place, and because it's a FIFO queue, the notification events get handled 
_before_ the later events.

So with the single-threaded situation, you basically end up always doing 
the events in the same order they came in. In the "two separate threads" 
case, you don't, and one thread will end up generating events forever, 
waiting for them to happen, but they never _do_ happen, so you have a 
lockup _and_ eventually an infinite event queue for the other thread.

> Or may be because it fixes all the current AMD-HP notebooks? 
> Or may be because it did not fail while being in -mm?

I'm afraid that -mm doesn't get as much testing as it used to get. 

Also, I do realize that the patch fixes other problems, but we have long 
had a very strict policy that we do NOT accept regressions. Immediately 
when you start accepting regressions, you will never know whether you're 
going forward of backwards. It's better to have a known _old_ bug than to 
introduce a new one.

So the "no regressions!" rule ends up trumping pretty much every single 
other issue. It's unacceptable to have machines that used to work, 
suddenly stop working. Even if it fixes another machine. 

ACPI didn't use to have that rule, and it was wild and crazy. Maybe more 
bugs got fixed, but the problem with accepting regressions is that nobody 
can _ever_ trust that system. You do not want to have people _afraid_ of 
upgrading - they should feel confident that upgrading never introduces any 
new problems.

(Of course, that can never be reached 100%, but it's very much part of the 
goal. It kind of falls into the same "backwards compatibility on 
interfaces" absolute goal: it's ok to do new things, but you can never 
allow them to break old programs)

> I will not "sneak it in" again, I promise. 

Feel free to send me test patches when working on these things, because I 
have no trouble at all to test my particular machine.

I think you'll find the ACPI dumps etc for that machine in your archives, 
because I've sent them to Len and the acpi lists several times, but if you 
want to get AML disassemblies etc, just tell me how. I've done them 
before, but I work on this seldom enough that I always forget what the 
magic incantations are, and where to get the tools etc.

		Linus
