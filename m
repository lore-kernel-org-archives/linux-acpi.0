From: Bernard Blackham <bernard@blackham.com.au>
Subject: Re: [ACPI] Re: Cause of Suspend2 resume failures on
	Toshiba laptops
Date: Tue, 8 Mar 2005 00:54:34 +0800
Message-ID: <20050307165434.GG5570@blackham.com.au>
References: <20050304175058.GA4042@blackham.com.au>
	<1110012298.6028.10.camel@DustPuppy.LNX.RO>
	<20050305100254.GH4042@blackham.com.au>
	<20050305175640.GL3485@openzaurus.ucw.cz>
	<20050305203533.GI4042@blackham.com.au>
	<20050307164800.GA28079@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307164800.GA28079@butterfly.hjsoft.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: John M Flinchbaugh <john@hjsoft.com>
Cc: acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 07, 2005 at 11:48:00AM -0500, John M Flinchbaugh wrote:
> On Sun, Mar 06, 2005 at 04:35:33AM +0800, Bernard Blackham wrote:
> > So, combining this patch with the previous kacpid NOFREEZE patch...
> > Does this make people happy? :) (And should it be submitted via Len
> > or akpm?)
> > -- 
> >  Bernard Blackham <bernard at blackham dot com dot au>
> 
> > --- linux-2.6.9-rc1/drivers/acpi/events/evgpe.c.orig	2005-03-06 04:29:40.000000000 +0800
> > +++ linux-2.6.9-rc1/drivers/acpi/events/evgpe.c	2005-03-06 04:29:49.000000000 +0800
> > @@ -253,10 +253,6 @@
> >  	ACPI_FUNCTION_TRACE ("ev_disable_gpe");
> >  
> >  
> > -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
> > -		return_ACPI_STATUS (AE_OK);
> > -	}
> > -
> >  	/* Make sure HW enable masks are updated */
> >  
> >  	status = acpi_ev_update_gpe_enable_masks (gpe_event_info, ACPI_GPE_DISABLE);
> 
> I'm looking into your patches in hopes to eliminate system freezes
> related to ACPI and swsusp on my Thinkpad R40.
> 
> I can apply this patch to 2.6.11.1, but the previous PF_NOFREEZE patch
> won't compile.  Would you mind providing a proper patch for 2.6.11.1
> that makes all the changes you intend?

The kacpid NOFREEZE patch is only relevant for Software Suspend 2.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
