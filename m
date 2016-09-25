From: Ondrej Zary <linux@rainbow-software.org>
Subject: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Sun, 25 Sep 2016 15:12:05 +0200
Message-ID: <201609251512.05657.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:46573 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966265AbcIYNSL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Sep 2016 09:18:11 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Hello,
I've upgraded kernel (Debian Squeeze - backports) from 4.6 (4.6.4-1~bpo8+1)
to 4.7 (4.7.2-1~bpo8+1) and IRQs stopped working with error messages like this:

ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

The same thing appeared on two different machines. Is it a known/fixed bug?

-- 
Ondrej Zary
