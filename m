From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Fri, 23 Dec 2005 12:12:39 +0100
Message-ID: <20051223111239.GB10748@elf.ucw.cz>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za> <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AB9CD2.9090106-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Cc: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>With regards to the ACPI code though - I've managed to fix all the 
> >>warnings and errors, except the one about the ResourceSource error, 
> >>which according to the spec is optional but iasl insists it's required. 
> >>No idea what I'm going to do about that.  Also not sure whether fixing 
> >>_WAK to always return a value will actually do something.
> >
> >I do not remember that i would have to fix any DSDT bugs, everything worked
> >with the original DSDT.
> 
> There is only really one error that bothers me, and I read somewhere 
> that the kernel doesn't look at it's value, and that is the _WAK call 
> that doesn't return a value.  Unless that of course changed recently. 
> And I can't recompile the DSDT due to those ResourceSource required 
> errors, which seems to be a bug in iasl.

Fix iasl, then ;-).

> I still haven't managed to finish of the resume process.  The screen 
> comes back up and console switching works but that is just about where 
> it ends.  I don't see any kernel panic messages either.  Will RTFM and 
> fool around some more.

RTFM will not help you here, I'm afraid. Try it with minimal kernel
config.
								Pavel

-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
