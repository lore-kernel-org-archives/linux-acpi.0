From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: nc4010 resume failure (was: ACPI S3 resume only reboots)
Date: Fri, 22 Oct 2004 12:51:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041022105103.GA1330@elf.ucw.cz>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it> <20041009130628.GA21781@elf.ucw.cz> <20041010105635.GA3362@doc.ic.ac.uk> <20041012175810.2920edf2.albeclemit@yahoo.it> <20041017193623.GB7476@elf.ucw.cz> <1098132147.4032.5.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1098132147.4032.5.camel@tyrosine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >  ENTRY(wakeup_start)
> > @@ -20,6 +35,7 @@
> >  	wakeup_code_start = .
> >  	.code16
> >  
> > +	BEEP
> >   	movw	$0xb800, %ax
> >  	movw	%ax,%fs
> >  	movw	$0x0e00 + 'L', %fs:(0x10)
> 
> I've been trying this on an HP nc4010. As far as I can tell, the code
> never even gets this far. The machine appears to suspend correctly - the
> sleep light flashes. Pressing the power button then causes the fan to
> switch on, but no beep is produced. This is with the gdt and
> virt_to_phys patches applied. What's the best way to proceed with
> debugging this?

Add infinite loop just after BEEP... if it crashed too fast after BEEP
you might not hear anything.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
