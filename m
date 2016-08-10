From: james harvey <jamespharvey20@gmail.com>
Subject: Should sBFT (InfiniBand version of iBFT) be included in actbl2.h?
Date: Tue, 9 Aug 2016 23:15:52 -0400
Message-ID: <CA+X5Wn4CzrOgjBaR96f_mKq-Y9fM_4wmjbvdmSOFe_b3+cUMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35899 "EHLO
	mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcHJDPy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2016 23:15:54 -0400
Received: by mail-ua0-f195.google.com with SMTP id 74so2573464uau.3
        for <linux-acpi@vger.kernel.org>; Tue, 09 Aug 2016 20:15:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm thinking no.

I'm developing a new ib_sbft kernel module, to provide a sysfs
interface to the InfiniBand SRP Boot Firmware Table.  It's
InfiniBand/SRP's version of the existing iscsi_ibft kernel module.

The existing iSCSI iBFT is mentioned in the ACPI 3.0b+ specs.  I
believe there are some instances when the iBFT is added to the
RSDT/XSDT.  The iBFT is part of actbl2.h.

Unlike the iBFT, the InfiniBand SRP sBFT is not mentioned in any of
the ACPI specs.  More importantly, the only implementations of the
sBFT that I'm aware of are iPXE and its predecessors/forks.  I'm
unaware of any implementations that add it to the RSDT/XSDT.

The iPXE/etc sBFT tables follow the specification at
http://etherboot.org/wiki/srp/sbft which mentions the sBFT follows the
structure of an ACPI table.  But the specification just says to scan
memory for it, nothing to do with the RSDT/XSDT.  I think they just
sort of mentioned this while modeling after the existing iBFT.

I'm thinking given the current limited state of the sBFT
implementations, it may as well be left out of actbl2.h until/unless
an implementation in the future adds it to the RSDT/XSDT.

I'm only vaguely familiar with ACPI, so I wanted to double check.
Please let me know if this is how the ACPI team would like it to be.
