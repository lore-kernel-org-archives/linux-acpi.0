From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 4 Nov 2004 11:58:48 +0100
Message-ID: <20041104105848.GB27533@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com> <20041103155217.GH24195@wotan.suse.de> <yzosm7q97q2.fsf@cern.ch> <20041103172120.GB18092@wotan.suse.de> <1099504898.31687.31.camel@elrond.flymine.org> <20041104041525.GE21211@wotan.suse.de> <1099564754.10723.24.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099564754.10723.24.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 04, 2004 at 10:39:14AM +0000, Matthew Garrett wrote:
> On Thu, 2004-11-04 at 05:15 +0100, Andi Kleen wrote:
> > On Wed, Nov 03, 2004 at 06:01:38PM +0000, Matthew Garrett wrote:
> > > On Wed, 2004-11-03 at 18:21 +0100, Andi Kleen wrote:
> > > 
> > > > earlyprintk to serial or vga if you're in text mode should always work.
> > > 
> > > On most machines, vga textmode won't work until the card is POSTed
> > > again.
> > 
> > But serial does.  
> 
> Few modern laptops have serial ports. 

Yes, that's an issue. USB EHCI has a special polled debug port mode
for this, but so far nobody has written a nice driver for it.

But anyways, as said VGA doesn't help you to debug VGA POST.
You always need some other debug channel.

I heard other people use LED on parport hacks, which probably works.

Anyways, this thread doesn't seem to serve any useful purpose
anymore so I won't post to it anymore.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
