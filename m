From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: still crap in pci_choose_state
Date: Tue, 12 Jul 2005 10:33:59 +0200
Message-ID: <20050712083359.GE1854@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575029F0E1A@pdsmsx402.ccr.corp.intel.com> <20050712075344.GB1854@elf.ucw.cz> <1121156888.18837.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1121156888.18837.3.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
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
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > >This is in drivers/pci/pci.c; and it is still wrong. You can't just
> > > >retype int into pm_message_t. Make it pm_message_t &state, and return
> > > >only success/failure in platform_pci_choose_state return value. Or add
> > > >PCI_POWER_ERROR to pci_power_t enum and use that.
> > > >								Pavel
> > > >
> > > >int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t
> > > state);
> > > >
> > > >pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> > > >{
> > > >        int     ret;
> > > >        if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > > >                return PCI_D0;
> > > >
> > > >        if (platform_pci_choose_state) {
> > > >                ret = platform_pci_choose_state(dev, state);
> > > >                if (ret >= 0)
> > > >                        state = ret;
> > > >        }
> > > >        switch (state) {
> > > Ok, I'll do it soon. Is the pm_message_t a structure now? I plan to fix
> > > it after pm_message_t structure change (current pm_message_t is really
> > > useless for ACPI), but maybe I should fix the bug at hand first.
> > 
> > I tried to turn pm_message_t into structure two times already, but
> > failed both times :-(. Fixing it after pm_message_t=>structure change
> > is a bit too late, because it will cause compile problems to akpm in
> > the meantime...
> Is this one ok with you? platform_choose_state accepts pm_message_t as a
> parameter seems ok to me. ACPI must know the suspend is S1, S3 or S4 and
> take different actions.

Yes, this one looks good to me.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
