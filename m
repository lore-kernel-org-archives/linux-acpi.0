From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2/2] i386/x86_64: collect host bridge resources v2
Date: Thu, 30 Jun 2005 09:05:06 -0700
Message-ID: <20050630160506.GD6828@kroah.com>
References: <20050602224147.177031000@csdlinux-1> <20050602224327.051278000@csdlinux-1> <20050628155152.A24551@jurassic.park.msu.ru> <1119982914.19258.6.camel@whizzy> <20050629000300.A26118@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050629000300.A26118-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Cc: Kristen Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2005 at 12:03:00AM +0400, Ivan Kokshaysky wrote:
> On Tue, Jun 28, 2005 at 11:21:54AM -0700, Kristen Accardi wrote:
> > I gave this patch a try (against mm2), and found that I now get many
> > errors on boot up complaining about not being able to allocate PCI
> > resources due to resource collisions, and then the system begins to
> > complain about lost interrupts on hda, and is never able to mount the
> > root filesystem.
> 
> Well, I'm not surprised. :-(
> Probably there is a conflict between e820 map and root bus ranges
> reported by ACPI. I think that it would be better to just drop
> gregkh-pci-pci-collect-host-bridge-resources-02.patch rather than
> try to fix it, at least until such conflicts can be resolved in
> a sane way.

Ok, I'll drop it.  Any objections to me doing this?

So, with the remaining pci patches, (as seen in
kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/pci/) are
there any objections to me pushing these (with the exception of the
above one) to Linus?  I think there was one report of the
pci-assign-unassigned-resources.patch patch causing boot problems on one
box, but that might have also been due to the above patch, am not sure.

Ah, the joys of acpi and pci resources... bleah.

thanks,

greg k-h


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
