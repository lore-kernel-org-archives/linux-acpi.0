From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 1/4] Create sony-laptop
Date: Wed, 07 Feb 2007 22:37:40 +0100
Message-ID: <1170884260.5674.10.camel@masamune.kami.home>
References: <11708749163025-git-send-email-malattia@linux.it>
	 <11708749161009-git-send-email-malattia@linux.it>
	 <200702071550.35808.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:44516 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161291AbXBGVjK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 16:39:10 -0500
In-Reply-To: <200702071550.35808.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Morton, Andrew" <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Wed, 2007-02-07 at 15:50 -0500, Len Brown wrote:
> Thanks for the follow-up Mattia, 
> 
> I've added this patch series to the acpi-test tree,
> and added Lindent patch on top of it.  I'll double check
> that it has all the patches from -mm and NAK those
> when I do, so andrew doesn't get messed up.

Thanks a lot Len!

> However, some things need to be addressed
> before it can go upstream:
> 
> What happens to sonypi?

Currently it's still needed, it deals with a different ACPI device (SPIC
instead of SNC). I'm still attempting to undrerstand how it could be
merged into sony-laptop. Will try to followup soon with more about that.
You can see them in DSDTs here:
http://oioio.altervista.org/linux/DSDT.sz72b.dsl
http://oioio.altervista.org/linux/DSDT.ux50.dsl

> Where is the patch to update MAINTAINERS for sony-laptop?
> Documentation/acpi/sony_acpi.txt needs a revision, and a re-name,
> and the Kconfig help text needs a revision too.

Yup, will send them asap (tomorrow, time to sleep here now).

> Finally, I don't have a Sony laptop so I can't test this.
> I'd like to see successful test feedback from Andrew,
> Luming, and other Sony owners before we push it.

Ok, I tested the driver on 2 recent models: SZ72B and UX50.

> ps. I recommend that at some point you globally replace "sony_acpi"
> in the driver with just "sony".

Ok.

Thanks again
-- 
mattia
:wq

