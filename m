From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [repost w/ PATCH] Wrong initialization in mp_config_acpi_legacy_irqs()
Date: Mon, 23 Jun 2003 14:17:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030623131752.GE2620@parcelfarce.linux.theplanet.co.uk>
References: <200306231232.OAA10526@max.zk-i.med.uni-muenchen.de> <20030623130827.GD2620@parcelfarce.linux.theplanet.co.uk> <200306231314.PAA10134@max.zk-i.med.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200306231314.PAA10134-s3DumOLytrggmRiqL7GssKtG+xunskDcZ+vKCSbpVNE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Wolfram Gloger <wmglo-icbQPRvlPmzsFLaNRtWx27DyIQmqzodN@public.gmane.org>
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 03:14:35PM +0200, Wolfram Gloger wrote:
> > Wy open-code the loop rather than:
> > 
> > -	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses);
> > +	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses * sizeof(int));
> 
> Please check the memset() specs.  memset() sets _bytes_ not ints.
> However, mp_bus_id_to_pci_bus[..] is compared to the integer -1 in
> other parts of the kernel.

this is Linux, not software engineering 101.  0xffffffff is the bitpattern
for (int) -1 on all Linux platforms.  And this is even in i386-specific
code.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
