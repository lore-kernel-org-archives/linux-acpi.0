From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 8/8] ACPI / trace: Add trace interface for eMCA driver
Date: Wed, 16 Oct 2013 14:20:56 +0200
Message-ID: <20131016122056.GE13608@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-9-git-send-email-gong.chen@linux.intel.com>
 <20131015165435.GA2777@naverao1-tp.ibm.com>
 <20131015170039.GF7908@pd.tnic>
 <525D7BCD.7080303@linux.vnet.ibm.com>
 <20131015214346.68718bcd.m.chehab@samsung.com>
 <20131016091640.GA13608@pd.tnic>
 <20131016073539.5a48f65e.m.chehab@samsung.com>
 <20131016104221.GC13608@pd.tnic>
 <20131016085558.19fe143a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48637 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932406Ab3JPMVM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 08:21:12 -0400
Content-Disposition: inline
In-Reply-To: <20131016085558.19fe143a@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aristeu Rozanski Filho <arozansk@redhat.com>, Steven Rostedt <srostedt@redhat.com>

On Wed, Oct 16, 2013 at 08:55:58AM -0300, Mauro Carvalho Chehab wrote:
> On that log, "physical addr: 0x0000000851fe0000 node: 0 card: 0 module: 0 rank: 0 bank: 0 row: 28927 column: 1296"
> is a string, instead of an hierarchical position, like what it is provided
> on EDAC.

So you can't split strings in userspace?

> Also, I suspect that, if an error happens to affect more than one DIMM
> (e. g. part of the location is not available for a given error), that
> the DIMM label will also not be properly shown.

That's unrelated to these patches and needs to be reported properly by
the firmware.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
