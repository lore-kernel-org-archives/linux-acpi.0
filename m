From: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Thu, 22 Dec 2005 15:15:01 +0100
Message-ID: <20051222141500.GA15412@g16.suse.de>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051222120413.GA28743-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Cc: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu 22. Dec - 13:04:13, Stefan Seyfried wrote:
> On Thu, Dec 22, 2005 at 12:02:19PM +0100, Pavel Machek wrote:
> > Hi
> > 
> > > I'm having some trouble with suspend/resume on my Toshiba Satellite P10 
> > > and was wondering whether anybody would be able to assist.
> > > 
> > > The omnibook module makes some functionality (like the multimedia keys, 
> > > temperature readings, LCD and FAN adjustments) available.  It however 
> > > does not help with suspend/resume at all.
> > > 
> > > It seems like the notebook only supports standby and suspend to ram.  It 
> > > seems to come out of standby almost immediately and never come out of 
> > > suspend to ram.  Running hibernate-ram -n works fine, but when running 
> > > it without -n it actually suspends to RAM, hdd spins down, network goes 
> > > down, CPU fans stop and the power led turns red (instead of the normal 
> > > blue - this is in accordance with what I've seen with Windows).
> > > 
> > > When it's time again to resume however, it just does nothing and I need 
> > > to power-cycle the machine to get it usable again.
> > 
> > P10... is it that beast with pentium4 and hyperthreading? Dual cpu
> > fans?
> > 
> > That worked for me. See Doc*/power/video.txt. Yep, that one works with
> > right config. Get swsusp working, first. Then you can debug s2ram.
> 
> Holger, do you have any hints on recent kernels on the P10? I have not
> touched this beast (the right noun for this brick :-) for a long time.

Tested with 2.6.14 kernels without hyperthreading and both suspend to disk
and suspend to ram are working when using acpi_sleep=s3_bios,s3_mode at
the boot prompt. Though, with smp kernels and hyperthreading enabled, both
are not working (video.txt already contains this information).

Regards,
        Holger


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
