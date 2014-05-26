From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Mon, 26 May 2014 12:21:51 +0200
Message-ID: <20140526102151.GE25732@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
 <20140523093703.GB21332@pd.tnic>
 <20140523101143.GC21332@pd.tnic>
 <20140526015944.GA31035@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39214 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbaEZKWA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 06:22:00 -0400
Content-Disposition: inline
In-Reply-To: <20140526015944.GA31035@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Sun, May 25, 2014 at 09:59:44PM -0400, Chen, Gong wrote:
> On Fri, May 23, 2014 at 12:11:43PM +0200, Borislav Petkov wrote:
> > +	TP_printk("%d %s error: %s %s %llx (mask lsb: %x), %s%s",
> What if pa_mask_lsb not existing?

Then you make it the default which says that all bits in the mask are
invalid: -1, i.e. 255.

This becomes part of the interface then, just like phys_addr is
0xfffff... ,i.e. -1 in the invalid case.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
