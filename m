From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: still crap in pci_choose_state
Date: Tue, 12 Jul 2005 16:28:08 +0800
Message-ID: <1121156888.18837.3.camel@linux-hp.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575029F0E1A@pdsmsx402.ccr.corp.intel.com>
	 <20050712075344.GB1854@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050712075344.GB1854-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
On Tue, 2005-07-12 at 09:53 +0200, Pavel Machek wrote:
> Hi!
> 
> > >This is in drivers/pci/pci.c; and it is still wrong. You can't just
> > >retype int into pm_message_t. Make it pm_message_t &state, and return
> > >only success/failure in platform_pci_choose_state return value. Or add
> > >PCI_POWER_ERROR to pci_power_t enum and use that.
> > >								Pavel
> > >
> > >int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t
> > state);
> > >
> > >pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> > >{
> > >        int     ret;
> > >        if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > >                return PCI_D0;
> > >
> > >        if (platform_pci_choose_state) {
> > >                ret = platform_pci_choose_state(dev, state);
> > >                if (ret >= 0)
> > >                        state = ret;
> > >        }
> > >        switch (state) {
> > Ok, I'll do it soon. Is the pm_message_t a structure now? I plan to fix
> > it after pm_message_t structure change (current pm_message_t is really
> > useless for ACPI), but maybe I should fix the bug at hand first.
> 
> I tried to turn pm_message_t into structure two times already, but
> failed both times :-(. Fixing it after pm_message_t=>structure change
> is a bit too late, because it will cause compile problems to akpm in
> the meantime...
Is this one ok with you? platform_choose_state accepts pm_message_t as a
parameter seems ok to me. ACPI must know the suspend is S1, S3 or S4 and
take different actions.

Thanks,
Shaohua

---

 linux-2.6.13-rc1-mm1-root/drivers/pci/pci-acpi.c |    4 ++--
 linux-2.6.13-rc1-mm1-root/drivers/pci/pci.c      |    8 ++++----
 linux-2.6.13-rc1-mm1-root/drivers/pci/pci.h      |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff -puN drivers/pci/pci.c~acpi_choose_state drivers/pci/pci.c
--- linux-2.6.13-rc1-mm1/drivers/pci/pci.c~acpi_choose_state	2005-07-12 16:00:23.533189008 +0800
+++ linux-2.6.13-rc1-mm1-root/drivers/pci/pci.c	2005-07-12 16:15:50.467273608 +0800
@@ -320,18 +320,18 @@ pci_set_power_state(struct pci_dev *dev,
  * Returns PCI power state suitable for given device and given system
  * message.
  */
-int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
 
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
-	int	ret;
+	pci_power_t	ret;
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
 	if (platform_pci_choose_state) {
 		ret = platform_pci_choose_state(dev, state);
-		if (ret >= 0)
-			state = ret;
+		if (ret != PCI_POWER_ERROR)
+			return ret;
 	}
 	switch (state) {
 	case 0: return PCI_D0;
diff -puN drivers/pci/pci-acpi.c~acpi_choose_state drivers/pci/pci-acpi.c
--- linux-2.6.13-rc1-mm1/drivers/pci/pci-acpi.c~acpi_choose_state	2005-07-12 16:02:40.560357712 +0800
+++ linux-2.6.13-rc1-mm1-root/drivers/pci/pci-acpi.c	2005-07-12 16:16:17.869107896 +0800
@@ -235,11 +235,11 @@ EXPORT_SYMBOL(pci_osc_control_set);
  * currently we simply return _SxD, if present.
  */
 
-static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
+static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
 {
 	/* TBD */
 
-	return -ENODEV;
+	return PCI_POWER_ERROR;
 }
 
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
diff -puN drivers/pci/pci.h~acpi_choose_state drivers/pci/pci.h
--- linux-2.6.13-rc1-mm1/drivers/pci/pci.h~acpi_choose_state	2005-07-12 16:04:39.624257248 +0800
+++ linux-2.6.13-rc1-mm1-root/drivers/pci/pci.h	2005-07-12 16:15:58.390069160 +0800
@@ -12,7 +12,7 @@ extern int pci_bus_alloc_resource(struct
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
 /* Firmware callbacks */
-extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t state);
 
 /* PCI /proc functions */
_




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
