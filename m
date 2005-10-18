From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model - takes 2
Date: Tue, 18 Oct 2005 10:32:17 -0700
Message-ID: <20051018103217.A24514@unix-os.sc.intel.com>
References: <59D45D057E9702469E5775CBB56411F19C4F95@pdsmsx406> <20051014124749.GD16113@parisc-linux.org> <1129599034.3965.6.camel@linux-hp.sh.intel.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1129599034.3965.6.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>; from shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Tue, Oct 18, 2005 at 09:30:34AM +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Rajesh <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 18, 2005 at 09:30:34AM +0800, Shaohua Li wrote:
> On Fri, 2005-10-14 at 06:47 -0600, Matthew Wilcox wrote:
> > On Fri, Oct 14, 2005 at 05:35:44PM +0800, Li, Shaohua wrote:
> > > The other issue is some ACPI drivers such as pci_root.c processor.c now
> > > support hotplug. They require two call backs (.add, .start). The
> > > callbacks are called in different sequence at the hotplug time and boot
> > > time. Linux driver model provides .probe callback, so it's hard to
> > > convert pci_root.c and processor.c.
> > 
> > Why do we need to have devices separately added and started?  What
> > prevents us from doing it all in one callback?  I can't quite follow
> > what the current code's doing, much less figure out why it's doing it.
> Current processor and pci root hotplug hope to do something between .add
> and .start for hotplug, such as allocating resources for hotpluged PCI
> devices, after the the devices are scanned (.add) and before binding the
> devices to their drivers (.start).  The idea is from Rajesh (CCed in the
> list), he can give us more details.
> 
The current code supports IO root bridge hotplug by separating pci
scan from pci start. The current flow is that we get an ACPI
interrupt and notify event on a hot-added root bridge that
transfers control to acpiphp. The acpi hotplug driver then adds
the root bridge to the ACPI device list, which invokes the .add
callback in pci_root.c. That code causes the pci scan of the
IO hierarchy hot-added and returns back to the acpiphp hotplug
driver. The hotplug driver then configures the hierarchy and
starts the devices via the acpi .start callback. The boot flow
uses the .add and .start callbacks too, except there's no
configuration step in the middle since we depend on BIOS to do
this for bridges/devices present at boot..

I haven't quite kept up with the discussions around the new
ACPI driver model. However, I have no objections to changes
in this area, as long as we have the ability to keep pci
device scan and start as separate, with a configuration
step in the middle.

Rajesh



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
