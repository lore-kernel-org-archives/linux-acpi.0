From: Aaron Durbin <adurbin@google.com>
Subject: ACPI device using sub-resource of PCI device
Date: Wed, 18 May 2016 10:54:06 -0500
Message-ID: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33903 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcERPyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2016 11:54:08 -0400
Received: by mail-yw0-f180.google.com with SMTP id j74so52363861ywg.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2016 08:54:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

We're currently running into a problem of resource conflicts with a
PCI device and ACPI devices.

[    0.243534] pci 0000:00:0d.0: can't claim BAR 0 [mem
0xd0000000-0xd0ffffff 64bit]: address conflict with INT3452:03 [mem
0xd0c00000-0xd0c03fff]

The PCI BAR covers a large amount mmio resources, however, there are
ACPI devices with their own HID (for probing) which uses resources
that are a subset of the PCI BAR.

Short of re-structuring the linux driver is there anything that can be
done with ASL to properly have the ACPI device use a sub-resource of
the PCI device during the ACPI/PCI probing?

Thanks for the help/insight.

-Aaron
