From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Hotplug PCI bridges
Date: Mon, 24 Mar 2003 12:19:28 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030324121928.GJ31008@parcelfarce.linux.theplanet.co.uk>
References: <20030323155122.GE31008@parcelfarce.linux.theplanet.co.uk> <20030324.145806.74724782.kochi@hpc.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030324.145806.74724782.kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 24, 2003 at 02:58:06PM +0900, Takayoshi Kochi wrote:
> > So.. how to fix?  Well, it depends.  Right now we have a half-arsed belief
> > that PCI root bridges can go away.  Either we need to stop believing it
> > or believe it properly.
> 
> Yes, they can.

OK.  In that case the existing code was broken as there was no way for
the acpiphp driver to be informed when the root bridge was removed.

> > If we believe it, we need to have some mechanism for having two drivers
> > for one device [1].  This doesn't need to be a generic mechanism; it's
> > fairly clear that acpiphp is a `subdriver' of pci_root and will always
> > be initialised after it.
> 
> For 2.4, there is no acpi_bus_register_driver in the stock kernel
> and we have luckily avoided the problem...

Well, yeah.  But I need the GPE Block support in the latest version of ACPI,
so I have to upgrade my ACPI CA.

> > I'm currently favouring an acpi_pci_{,un}register_driver() interface with
> > add and remove callbacks, since it's the least amount of code change
> > without disbelieving pci root bridge removal.
> 
> I have no objection for going for it.

OK.  Will implement today.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
