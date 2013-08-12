From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Date: Mon, 12 Aug 2013 08:33:55 -0300
Message-ID: <20130812083355.47c1bae8@samsung.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:39025 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab3HLLeE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Aug 2013 07:34:04 -0400
In-reply-to: <20130810180322.GC4155@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Em Sat, 10 Aug 2013 20:03:22 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Aug 08, 2013 at 04:38:22PM -0300, Mauro Carvalho Chehab wrote:
> > Em Thu, 08 Aug 2013 23:57:51 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:
> > 
> > > Enable memory error trace event in cper.c
> > 
> > Why do we need to do that? Memory error events are already handled
> > via edac_ghes module,
> 
> If APEI gives me all the required information in order to deal with the
> hardware error - and it looks like it does - then the additional layer
> of ghes_edac is not needed.

APEI is just the mechanism that collects the data, not the mechanism
that reports to userspace.

The current implementation is that APEI already reports those errors
via ghes_edac driver. It also reports the very same error via MCE
(although the APEI interface to MCE is currently broken for everything
that it is not Nehalem-EX - as it basically emulates the MCE log for
that specific architecture).

I really don't see any sense on adding yet-another-way to report the
very same error.

Regards,
Mauro
