From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] PCI: add proper MCFG table parsing to ACPI core.
Date: Tue, 14 Jun 2005 11:37:30 +0200
Message-ID: <20050614093730.GD11898@wotan.suse.de>
References: <20050614063745.GA19556@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050614063745.GA19556-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 13, 2005 at 11:37:46PM -0700, Greg KH wrote:
> In order to handle the MCFG ACPI table properly, we need to at least
> parse the thing properly :)  So, here's a patch that adds support for
> this.  It's against my latest PCI tree (which is included in -mm) but
> will apply with a bit of fuzz against 2.6.12-rc6.
> 
> I've tested this out on boxes that only have 1 MCFG config table, if
> anyone has access to ones that have more than this, I'd be interested to
> see how well it works.  Based on the comments in the mmconfig.c file,
> I'm guessing that various AMD boxes are like this...

All the AMD boxes with PCI-Express. The internal busses of the
Northbridge don't support MMCONFIG, but the PCI-Express busses
do. 

> 
> Anyone have any objections to this patch?

Looks good as a first step. Next step will be to query the
PCI segment group numbers and then assign different pci ops to the different 
busses based on that.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
