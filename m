From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: RE: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Wed, 19 Jan 2005 22:17:16 +0100
Message-ID: <20050119211716.GA4066@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575F054DA@pdsmsx402.ccr.corp.intel.com> <200501151053.24075.stefandoesinger@gmx.at> <20050116215308.GG2757@elf.ucw.cz> <200501191636.15174.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200501191636.15174.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > ACPI spec also said _PTS (in 'acpi_enter_sleep_state_prep') should be
> > > > called after all devices are suspend (ACPI sepc 3.0 P401), could you
> > > > please also change the order of device suspend and
> > > > 'acpi_enter_sleep_state_prep'?
> > >
> > > Sorry for the delay, but I was quite busy this week. Here is the updated
> > > patch which also causes pm_ops->prepare to be called after device
> > > suspend. Is this correct or should I create another new function? What
> > > does the spec say?
> >
> > Creating another function seems right. Even if ACPI does not need it,
> > some other suspend mechanism will need it.
> 
> Allright, here it is. This patch introduces two new suspend/resume functions, 
> pm_ops->setup and pm_ops->leave. There are now 5 functions:
> 
> prepare: It's called before devices are suspended
> setup: Called after device suspend but before finally going to sleep
> enter: Last suspend function
> leave: Called before devices are beeing resumed
> finish: Last function, called after device resume

Add this as a comment to pm.h and you have my Acknowledged-by: :-)

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
