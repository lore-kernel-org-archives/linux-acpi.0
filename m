From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 23:44:52 +0200
Message-ID: <200805092344.53713.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org> <200805091934.41341.rjw@sisk.pl> <200805091037.23767.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52339 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbYEIVo7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 May 2008 17:44:59 -0400
In-Reply-To: <200805091037.23767.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Friday, 9 of May 2008, Jesse Barnes wrote:
> On Friday, May 09, 2008 10:34 am Rafael J. Wysocki wrote:
> > > So in this case pci_choose_state would either change state or leave it
> > > untouched if it didn't have a better idea about things.  But now that I
> > > look at it I'm not sure it's an improvement. :)
> >
> > Well, in principle we could go farther and introduce a wrapper around
> > pci_set_power_state() that will call platform_pci_choose_state() to obtain
> > the new state or use the driver-provided one if that fails.
> 
> Hm, yeah that sounds pretty reasonable actually.  Especially given that so 
> many drivers just do:
>   pci_set_power_state(pdev, pci_choose_state(pdev, state));
> anyway...

Okay, what about this:

---
From: Rafael J. Wysocki <rjw@sisk.pl>

The new suspend and hibernation callbacks introduced with
'struct pm_ops' and 'struct pm_ext_ops' do not take a
pm_message_t argument, so the drivers using them will not be able
to use pci_choose_state() in its present form.  For this reason,
introduce a new function, pci_choose_and_set_state(), playing the
role of pci_choose_state() combined with pci_set_power_state() and
allowing the driver to put the device into a power state chosen by
the platform.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |    1 +
 2 files changed, 46 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -509,7 +509,51 @@ pci_set_power_state(struct pci_dev *dev,
 }
 
 pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
- 
+
+/**
+ * pci_choose_and_set_state - Choose the power state of a PCI device and put
+ *                            the device into that state.
+ * @dev: PCI device to be put into a low power state
+ * @state: State to put the device into by default
+ *
+ * Use the platform driver to choose the preferred PCI power state of given
+ * device and put the device into that state.  If the target power state of
+ * the device cannot be chosen using the platform driver, the driver-provided
+ * @state is used.
+ *
+ * RETURN VALUE:
+ * -EINVAL if trying to enter a lower state than we're already in.
+ * 0 if we're already in the requested state.
+ * -EIO if device does not support PCI PM.
+ * 0 if we can successfully change the power state.
+ */
+
+int pci_choose_and_set_state(struct pci_dev *dev, pci_power_t state)
+{
+	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+		return -EIO;
+
+	if (platform_pci_choose_state) {
+		pci_power_t ret = platform_pci_choose_state(dev);
+
+		switch (ret) {
+		case PCI_POWER_ERROR:
+		case PCI_UNKNOWN:
+			break;
+		case PCI_D1:
+		case PCI_D2:
+			if (pci_no_d1d2(dev))
+				break;
+		default:
+			state = ret;
+		}
+	}
+
+	return pci_set_power_state(dev, state);
+}
+
+EXPORT_SYMBOL(pci_choose_and_set_state);
+
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -615,6 +615,7 @@ size_t pci_get_rom_size(void __iomem *ro
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_choose_and_set_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
