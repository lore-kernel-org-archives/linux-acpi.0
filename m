From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Tue, 25 Oct 2011 11:39:08 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D5301F1F36568@orsmsx505.amr.corp.intel.com>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
 <4EA62396.2070002@intel.com>
 <CAErSpo5cW14d5BM7_XJiL1o2ryamWUO3_uz5LBiyooApdbizQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32461 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab1JYSjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2011 14:39:13 -0400
In-Reply-To: <CAErSpo5cW14d5BM7_XJiL1o2ryamWUO3_uz5LBiyooApdbizQg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Myron posted a nice patch recently to remove atomicio.c altogether:
> http://marc.info/?l=linux-acpi&m=131733358818849&w=2
>
> I haven't seen any response to it, but I think it's a nice approach
> and it gets rid of all this special-case pre-map, post-unmap, atomic
> read/write stuff.

Does that meet the needs of the:

  panic in NMI/machine check context
    kmsg_dump
      pstore
        ERST
          acpi reads & writes

call chain?  I thought that atomicio was created for paths where the normal
acpi operations had problems in NMI contexts.

-Tony
	
