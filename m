From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.18-mm1 -- ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
Date: Wed, 27 Sep 2006 22:35:10 -0700
Message-ID: <a44ae5cd0609272235v4e54824dl4e7ac4718e503cc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:43681 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1031359AbWI1FfK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 01:35:10 -0400
Received: by py-out-1112.google.com with SMTP id n25so593941pyg
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2006 22:35:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

When I booted last time, I found that my X pointer was frozen.  When I
switched to a VT and ran dmesg, I found:

[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 19
[drm] Initialized i915 1.5.0 20060119 on minor 0
[drm] Initialized i915 1.5.0 20060119 on minor 1
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for
[OpcodeName unavailable] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.ACAD._PSR] (Node c1e3f464), AE_TIME
ACPI Exception (acpi_ac-0096): AE_TIME, Error reading AC Adapter state
[20060707]
ACPI: read EC, IB not empty
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.BAT0._BST] (Node c1e3f624), AE_TIME
ACPI Exception (acpi_battery-0206): AE_TIME, Evaluating _BST [20060707]
ACPI: read EC, IB not empty
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for
[OpcodeName unavailable] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.ACAD._PSR] (Node c1e3f464), AE_TIME
ACPI Exception (acpi_ac-0096): AE_TIME, Error reading AC Adapter state
[20060707]
ACPI: read EC, IB not empty
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.BAT0._BST] (Node c1e3f624), AE_TIME
ACPI Exception (acpi_battery-0206): AE_TIME, Evaluating _BST [20060707]
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ACPI: read EC, IB not empty
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
ACPI: read EC, IB not empty
