From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Hotplug PCI bridges
Date: Sun, 23 Mar 2003 15:51:22 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030323155122.GE31008@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


I just updated my ia64 tree to ACPI-20030321 and it no longer allows
multiple drivers to claim the same device.  Which is the right thing,
obviously, but it breaks PCI hotplug since we now have two drivers which
want to claim the same devices (pci_root.c and acpiphp).

So.. how to fix?  Well, it depends.  Right now we have a half-arsed belief
that PCI root bridges can go away.  Either we need to stop believing it
or believe it properly.

If we disbelieve it, we can remove the acpi_pci_root_remove() function,
and return an error code from acpi_pci_root_add() so we don't claim it.

If we believe it, we need to have some mechanism for having two drivers
for one device [1].  This doesn't need to be a generic mechanism; it's
fairly clear that acpiphp is a `subdriver' of pci_root and will always
be initialised after it.

I'm currently favouring an acpi_pci_{,un}register_driver() interface with
add and remove callbacks, since it's the least amount of code change
without disbelieving pci root bridge removal.  If the collected wisdom
is that PCI root busses never _really_ go away, then I'm happy to just
return an error code from acpi_pci_root_add().

[1] We can't do this all with one driver.  The PCI hotplug core doesn't
get initialised until much later.  Maybe that's a bug, but it's certainly
too late to fix it in 2.4.  Maybe we could fix that in 2.5?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
