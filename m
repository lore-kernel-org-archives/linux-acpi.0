From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model -
	 takes 2
Date: Tue, 18 Oct 2005 09:30:34 +0800
Message-ID: <1129599034.3965.6.camel@linux-hp.sh.intel.com>
References: <59D45D057E9702469E5775CBB56411F19C4F95@pdsmsx406>
	 <20051014124749.GD16113@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051014124749.GD16113-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Rajesh <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-10-14 at 06:47 -0600, Matthew Wilcox wrote:
> On Fri, Oct 14, 2005 at 05:35:44PM +0800, Li, Shaohua wrote:
> > The other issue is some ACPI drivers such as pci_root.c processor.c now
> > support hotplug. They require two call backs (.add, .start). The
> > callbacks are called in different sequence at the hotplug time and boot
> > time. Linux driver model provides .probe callback, so it's hard to
> > convert pci_root.c and processor.c.
> 
> Why do we need to have devices separately added and started?  What
> prevents us from doing it all in one callback?  I can't quite follow
> what the current code's doing, much less figure out why it's doing it.
Current processor and pci root hotplug hope to do something between .add
and .start for hotplug, such as allocating resources for hotpluged PCI
devices, after the the devices are scanned (.add) and before binding the
devices to their drivers (.start).  The idea is from Rajesh (CCed in the
list), he can give us more details.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
