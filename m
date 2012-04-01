From: =?ISO-8859-1?Q?J=F6rg_Otte?= <jrg.otte@googlemail.com>
Subject: [V3.4-rc1] ACPI regression
Date: Sun, 1 Apr 2012 12:37:15 +0200
Message-ID: <CADDKRnAOzjpKWp_BMYROAGM4iYsNgSLk1vHn7UJ96WjvBiDR=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43879 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab2DAKhQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2012 06:37:16 -0400
Received: by iagz16 with SMTP id z16so2871196iag.19
        for <linux-acpi@vger.kernel.org>; Sun, 01 Apr 2012 03:37:15 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi,

on my Notebook ( Thinkpad T43) I can not boot with V3.4-rc1.

The kernel stops booting after displaying the following:

 ACPI: Core revision 20120320
 ACPI: setting ELCR to 0200 (from 0800)
 Performance Events: p6 PMU driver.
 ... version:                0
 ... bit width:              32
 ... generic registers:      2
 ... value mask:             00000000ffffffff
 ... max period:             000000007fffffff
 ... fixed-purpose events:   0
 ... event mask:             0000000000000003
 devtmpfs: initialized
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
 PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
 PCI: Using MMCONFIG for extended config space
 PCI: Using configuration type 1 for base access
 bio: create slab <bio-0> at 0
 ACPI: Added _OSI(Module Device)
 ACPI: Added _OSI(Processor Device)
 ACPI: Added _OSI(3.0 _SCP Extensions)
 ACPI: Added _OSI(Processor Aggregator Device)
 ACPI: EC: EC description table is found, configuring boot EC

Comparing this with the displays of kernel v3.3 the next expected
outputs would be:

 ACPI: Interpreter enabled
 ACPI: (supports S0 S5)

Regards,
Joerg Otte
