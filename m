From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Coverity CID 134632: acpi_hw_build_pci_list() memory leak
Date: Thu, 3 Apr 2014 10:22:25 -0600
Message-ID: <CAErSpo4-c1Wb-gtaBGrVq557330PHKrB_mB3Hk+xdt_BtBYFVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:44801 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbaDCQWq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Apr 2014 12:22:46 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so7967260igb.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2014 09:22:46 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Coverity complains that acpi_hw_build_pci_list() leaks memory when it
returns here:

201                if (!list_element) {

CID 134632 (#1 of 2): Resource leak (RESOURCE_LEAK)
13. leaked_storage: Variable list_head going out of scope leaks the
storage it points to.
202                        return (AE_NO_MEMORY);
203                }

We're building up a list, and if we fail to allocate another element,
we return failure without deallocating the already built-up list.

This is CID 134632.

Bjorn
