From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Wed, 23 Mar 2005 08:54:09 +0800
Message-ID: <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <41062.15.99.19.46.1111525073.squirrel-hO9VIT4gnBFxnVILBQAtiA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>, Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-03-23 at 04:57, Bjorn Helgaas wrote:
> > Your patch applied with some problems:
> >
> > patching file arch/i386/pci/irq.c
> > Hunk #2 succeeded at 1081 with fuzz 2 (offset 1 line).
> > patching file drivers/acpi/pci_irq.c
> > patching file drivers/pci/quirks.c
> > Hunk #1 succeeded at 678 (offset -5 lines).
> 
> These indicate minor differences in these files between upstream BK
> (which is what my patch was against) and the kernel you're building.
> You can ignore them.
> 
> > Then I tested it and it works (at least my speedtouch still works).
> 
> Great.  Shaohua, where should we go from here?  Do you have more
> concerns with the current patch, or should we ask Andrew to put it
> in -mm?  If you do have concerns, would you like to propose an
> alternate patch that fixes the problem for Grzegorz?
No, the patch is great to me.

Thanks,
Shaohua



-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
