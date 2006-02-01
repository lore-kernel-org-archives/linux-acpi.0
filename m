From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [Patch:000/004] Unify pxm_to_node id ver.2.
Date: Wed, 01 Feb 2006 21:36:16 +0900
Message-ID: <20060201205152.41E6.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:33491 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932434AbWBAMgw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Feb 2006 07:36:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, Bob Picco <bob.picco@hp.com>, Andy Whitcroft <apw@shadowen.org>, Paul Jackson <pj@sgi.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>, ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org, x86-64 Discuss <discuss@x86-64.org>

Hello.

I rewrote patches to unify mapping from pxm to node id as ver.2.
I already posted all of fixes for ver.1.
However, searching first patch and appling fixes are a bit messy
due to too many mail and patches in LKML.
So, I rearranged them to find all of them easier.
Basically, (ver.1 + previous fix patches) = ver.2.
But ver.2 is set of following patches.
  - generic code.
  - for ia64.
  - for x86_64.
  - for i386.

Fixes from ver.1 are followigs.
  - They are for 2.6.16-rc1-mm4.
  - Fix old map from HP and SGI's code by Bob Picco-san.
  - Remove MAX_PXM_DOMAINS from asm-ia64/acpi.h. It is already defined at
    include/acpi/acpi_numa.h.
  - Fix return code of setup_node() at arch/x86_64/mm/srat.c
  - Fix ACPI_NUMA config for i386 by Andy Witcroft-san.
  - Define dummy functions for i386's compile error.
  - Remove garbage nid_to_pxm_map from acpi20_parse_srat() 
    at arch/i386/kernel/srat.c

I tested ia64 and x86_64 with dummy SRAT NUMA emulation.
And I checked compile completion for hp, SGI, and Summit.

Andrew-san. Please apply.

Thanks.

----------------------------------

This patch is to unify mapping from pxm to node id.
In current code, i386, x86-64, and ia64 have its mapping by each own code.
But PXM is defined by ACPI and node id is used generically. So,
I think there is no reason to define it on each arch's code.
This mapping should be written at drivers/acpi/numa.c as a common code.


-- 
Yasunori Goto 


