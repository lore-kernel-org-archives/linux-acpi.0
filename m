From: "Alexander Beregalov" <a.beregalov@gmail.com>
Subject: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Tue, 8 Jul 2008 16:18:02 +0400
Message-ID: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:23623 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbYGHMSE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jul 2008 08:18:04 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1774586wri.5
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jul 2008 05:18:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, jbarnes@virtuousgeek.org, ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org

Hi Rafael

drivers/pci/pci-acpi.c: In function 'acpi_pci_sleep_wake':
drivers/pci/pci-acpi.c:311: error: implicit declaration of function
'acpi_pm_device_sleep_wake'

drivers/pci/pci-acpi.c:
309-static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
310-{
311:    int error = acpi_pm_device_sleep_wake(&dev->dev, enable);


include/acpi/acpi_bus.h:
381-#ifdef CONFIG_PM_SLEEP
382-int acpi_pm_device_sleep_state(struct device *, int *);
383:int acpi_pm_device_sleep_wake(struct device *, bool);
384-#else /* !CONFIG_PM_SLEEP */
385-static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
386-{
387-    if (p)
388-            *p = ACPI_STATE_D0;
389-    return ACPI_STATE_D3;
390-}
391-#endif /* !CONFIG_PM_SLEEP */
