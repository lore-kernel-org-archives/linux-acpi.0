From: Andreas Mohr <andi@rhlx01.hs-esslingen.de>
Subject: [PATCH] drivers/acpi/Kconfig cleanup
Date: Mon, 4 Jun 2007 22:25:58 +0200
Message-ID: <20070604202557.GA8456@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:46752 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbXFDUZ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jun 2007 16:25:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

> Hi,
> 
> ACPI Kconfig cleanup, few updates and mostly typos.
> 
> - fix CONFIG_ACPI description
> - excuse me, but I thought that CONFIG_ACPI_SLEEP has been ok for
>   almost half a decade now? --> Remove misleading text.
> - mention brokenness of some older Intel chipsets in CONFIG_X86_PM_TIMER
> - spelling / cleanup
> 
> Patch against 2.6.22-rc1-mm1, however I'd want this to end up in
> acpi-linux-2.6 (and thus 2.6.23 probably),
> hopefully there are no conflicts.
> 
> Thanks!

Any opinions on this one? (sent on 20070517)

I hope my spamfilter setup didn't kill any replies (checked, didn't see it).

Where to send such a patch if it's not considered to be ACPI core tree
related?
-mm or kernel janitors, I guess.

Thanks!

Andreas Mohr
