From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Re: swsusp and ac status
Date: Wed, 30 Jun 2004 03:33:45 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040630003345.GC9412@luna.mooo.com>
References: <200406250701.i5P71GKC006204@fermat.unipv.it> <opr95d71ln4evsfm@smtp.pacific.net.th> <20040625151421.GA8852@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040625151421.GA8852-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 25, 2004 at 03:14:22PM -0000, Stefan Seyfried wrote:
> On Fri, Jun 25, 2004 at 07:29:51PM +0800, Michael Frank wrote:
> 
> > >It is NOT in my case. It is one of the first things I did. Now, just
> > >in case, I gave it another try, but it does not work.
> > >
> > >modprobe -r ac
> > >suspend
> > >unplug
> > >resume
> > >modprobe ac
> > >
> > >cat /proc/acpi/ac_adapter/C131/state
> > >state: on-line
> > >
> > >If now, after resuming, I plug and unplug the adapter...
> > >
> > >cat /proc/acpi/ac_adapter/C131/state
> > >state: off-line
> 
> I have exactly the same on a hp compaq nx 5000.
> 
> > Too bad, this implies that the AC module does not get reinitialized after
> > resume and I suspect that acpi core is broken on 2.6 in this regard.
> 
> Pavel and i and some HP BIOS engineers analyzed this problem and pavel
> proposed an ugly hack in his swsusp code to work around this. I have
> to check back in my archives / bugzilla reports for this.
> The funny thing is, that the BIOS is 100% correct and this leads to this
> problem (at least that was what Pavel concluded). HP would have changed
> the BIOS to work around the linux bug, but this would be even more ugly.
> I will dig my archives for more info and a (probably ugly, but maybe
> somehow working) patch. I'm offline on the train now, so this will have
> to wait until monday.
>  
> > I'll compile 2.6 and try it on my HW.
> 
> It is completely hardware dependent, i only saw it on the nx5000 up to
> now.

Also saw this on a sony vaio pcg-fxa53 (via + amd 1300+)
> 
> > Perhaps the ACPI people could advise how to increase debug verbosity
> > to see what happens or if that can't be done, put some printks into AC
> > module to see what happens when the module is loaded on resume.
> 
> I am not even sure that the AC module is to blame, i have to check
> my archives, i don't remember all the gory details.

For me compiling battery as a module and unloading/swsusp/resume
bypasses the problem.

> -- 
> Stefan Seyfried
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
