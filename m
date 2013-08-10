From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Sat, 10 Aug 2013 20:03:22 +0200
Message-ID: <20130810180322.GC4155@pd.tnic>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53897 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab3HJSDZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Aug 2013 14:03:25 -0400
Content-Disposition: inline
In-Reply-To: <20130808163822.67e0828a@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 08, 2013 at 04:38:22PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 08 Aug 2013 23:57:51 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:
> 
> > Enable memory error trace event in cper.c
> 
> Why do we need to do that? Memory error events are already handled
> via edac_ghes module,

If APEI gives me all the required information in order to deal with the
hardware error - and it looks like it does - then the additional layer
of ghes_edac is not needed.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
