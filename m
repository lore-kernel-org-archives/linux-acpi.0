From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] pci: increase alignment to make more space for hidden
	code
Date: Mon, 12 Oct 2009 21:22:42 +0200
Message-ID: <20091012192242.GA2691@elte.hu>
References: <200908072333.24631.storm@sys49152.net> <4ACAC8F1.1050706@kernel.org> <4AD24B5C.4050905@kernel.org> <200910121059.10366.bjorn.helgaas@hp.com> <4AD37CA4.90601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46990 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811AbZJLTYH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Oct 2009 15:24:07 -0400
Content-Disposition: inline
In-Reply-To: <4AD37CA4.90601@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Ricardo Jorge da Fonseca Marques Ferreira <storm@sys49152.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Yannick Roehlly <yannick.roehlly@free.fr>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, x86@kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> > This feels like a hack that accidentally covers up the problem.  I 
> > don't think we understand what's happening well enough.
> 
> yes, we need to figure out why when acpi=on, those BAR are cleared, 
> before pci code try to scan and read BAR. (node early pic print out 
> untouched, but after APCI subsystem is enabled, those BAR got 
> clearred)

I'm wondering, how did it get cleared - some AML script told the kernel 
to clear it?

	Ingo
