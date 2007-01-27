From: Andrew Morton <akpm@osdl.org>
Subject: x86_64-mm-always-use-physical-delivery-mode-on-8-cpus vs git-acpi
Date: Fri, 26 Jan 2007 17:24:02 -0800
Message-ID: <20070126172402.77a3edbc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:35262 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbXA0BZh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 20:25:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Andi Kleen <ak@muc.de>, linux-acpi@vger.kernel.org


The new stuff which just landed in Len's tree caused a huge mess in
arch/x86_64/kernel/genapic.c:clustered_apic_check() when applying
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/always-use-physical-delivery-mode-on-8-cpus
on top of it.

In fact the ACPI change has trashed a fair slice of Andi's pending tree.

I think I'll revert to yesterday's git-acpi, let you guys sort it all out.

