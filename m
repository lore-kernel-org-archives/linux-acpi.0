From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Thu, 16 Dec 2010 21:54:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012162149370.20940@x980>
References: <20101214220932.GA1206@sgi.com>
 <alpine.LFD.2.00.1012141903210.25387@x980> <20101215024136.GB19601@sgi.com>
 <alpine.LFD.2.00.1012142302110.4878@x980> <20101215164635.GA27373@sgi.com>
 <alpine.LFD.2.00.1012151536510.21167@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:36942 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0LQCzF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Dec 2010 21:55:05 -0500
In-reply-to: <alpine.LFD.2.00.1012151536510.21167@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: hpa@zytor.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

> I'll bet we can improve the boot sequence so that
> some of the stuff we do before we have cached mappings
> we can do with cached mappings...

Nope, that is a losing bet...

The early mappings are temporary, but they are cached,
for they use __pgprot(__PAGE_KERNEL_IO), which is 
(__PAGE_KERNEL | _PAGE_IOMAP)

rather than __pgprot(__PAGE_KERNEL_IO_NOCACHE) or its variants.

We just need to update the permanent mappings to match.

cheers,
Len Brown, Intel Open Source Technology Center

