From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: still crap in pci_choose_state
Date: Mon, 11 Jul 2005 20:27:38 +0200
Message-ID: <20050711182738.GA1978@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This is in drivers/pci/pci.c; and it is still wrong. You can't just
retype int into pm_message_t. Make it pm_message_t &state, and return
only success/failure in platform_pci_choose_state return value. Or add
PCI_POWER_ERROR to pci_power_t enum and use that.
								Pavel

int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);

pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
{
        int     ret;
        if (!pci_find_capability(dev, PCI_CAP_ID_PM))
                return PCI_D0;

        if (platform_pci_choose_state) {
                ret = platform_pci_choose_state(dev, state);
                if (ret >= 0)
                        state = ret;
        }
        switch (state) {
 

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
