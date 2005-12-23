From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Fri, 23 Dec 2005 18:24:59 +0100
Message-ID: <20051223172459.GB15357@elf.ucw.cz>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za> <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za> <20051223111239.GB10748@elf.ucw.cz> <43AC2B95.9060901@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AC2B95.9060901-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Cc: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>I still haven't managed to finish of the resume process.  The screen 
> >>comes back up and console switching works but that is just about where 
> >>it ends.  I don't see any kernel panic messages either.  Will RTFM and 
> >>fool around some more.
> > 
> > RTFM will not help you here, I'm afraid. Try it with minimal kernel
> > config.
> 
> Ok, that sucks.  This is what I get, one some VT that is not reachable
> with Alt+Fx, I get this:
> 
>          inu
> Back to C!
> ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ
>177


> The inu is in yellow and I presume forms part of the word "Linux".  I
> get this screen when it comes back, from here I can switch to all twelfe
> VTs with Alt+Fx, and back to this screen with Alt+right from tty1.

Yep, "Linux" is printed from assembly header. Fortunately your machine
gets into C, so you'll not have to debug _that_. You can just debug it
using printk().

But try _minimal config_, first.

> On tty1 I can type, but that is the only VT.  This is also the VT I run
> hibernate-ram from.  Auto-repeat however does not function.  The same
> applies when running "echo mem > /sys/power/state"
> 
> When running hibernate it doesn't power down!  This seems odd since
> powerdown works when going "init 0".  Anyhow, the last messages I see is
> this:
> 
> Freezing processes
> Preparing Image.
> Starting to save the image..
> Writing caches...
> Doing atormic copy.
> Writing kernel & process data...
> 
> And that is where it all stops.

See Doc*/power/swsusp.txt. suspend to disk should be easier to fix.

								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
