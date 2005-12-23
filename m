From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Sat, 24 Dec 2005 00:01:33 +0100
Message-ID: <20051223230133.GC16104@elf.ucw.cz>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za> <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za> <20051223111239.GB10748@elf.ucw.cz> <43AC2B95.9060901@kroon.co.za> <20051223172459.GB15357@elf.ucw.cz> <43AC80F3.6040605@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AC80F3.6040605-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
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

> > But try _minimal config_, first.
> 
> Doesn't include CONFIG_NET imho, but kernel/power/ui.h (part of
> suspend2?) doesn't compile without it.  I can probably write a patch,
> the problem seems to be that ui_helper_data only gets declared if
> CONFIG_NET is set, but it gets used elsewhere even if CONFIG_NET is
> not set.

You did not tell me your kernel contains suspend2. Revert those
patches. In-kernel code tends to have less bells/whistles, but seems
more reliable to me. (And it is the only one I can help you with.)

> Setting CONFIG_NET works around this problem.
> 
> With almost nothing in the kernel though (only what is essential to make
> it boot) suspend-to-ram works.  Still suspend-to-disk though.
> 
> Guess it's time to go find the module that causes the problem and fix it
> (if I can figure it out).

Yep ;-). Keep us updated with name of offending module.

								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
