From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpiphp: Match the variable types for ia64
Date: Fri, 10 Oct 2008 02:20:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810100217370.3007@localhost.localdomain>
References: <200510232100.j9NL0MWA030225@shell0.pdx.osdl.net>
 <20080910002011.GF2772@parisc-linux.org>
 <20080910074940.GA12737@ldl.fc.hp.com>
 <200809101103.55222.jbarnes@virtuousgeek.org>
 <B57D568CB82B0C4B897F9CD9862DE8B733A328DF9E@GVW1097EXB.americas.hpqcorp.net>
 <20080911104345.GL2772@parisc-linux.org>
 <B57D568CB82B0C4B897F9CD9862DE8B733A328E8E0@GVW1097EXB.americas.hpqcorp.net>
 <20080912183213.GH10844@parisc-linux.org>
 <4911F71203A09E4D9981D27F9D8308584E454A@orsmsx503.amr.corp.intel.com>
 <20080915184509.GA29454@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:48587 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYJJGUg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 02:20:36 -0400
In-reply-to: <20080915184509.GA29454@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Chen, Justin" <justin.chen@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Chiang, Alexander" <achiang@hp.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>


> [PATCH] Change acpi_evaluate_integer to support 64-bit on 32-bit kernels

Matt,
I applied this patch, but first i global replaced
acpi_integer with "unsigned long long" because we
actually don't actually want that ACPICA type spreading
any more out of the ACPICA code than necessary.

Yes, it boots:-)
It has a couple of conflicts with other pathces
in my queue, and when i sift through those
(friday), it will appear in my public test tree.

thanks,
-Len


