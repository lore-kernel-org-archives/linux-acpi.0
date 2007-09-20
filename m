From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba Satellite A40
Date: Thu, 20 Sep 2007 12:53:12 +0200
Message-ID: <20070920105312.GC12157@atrey.karlin.mff.cuni.cz>
References: <200709192014.08443.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35224 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXITKxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2007 06:53:13 -0400
Content-Disposition: inline
In-Reply-To: <200709192014.08443.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> When compared with 2.6.22-4, dmesg no longer lists S4 and S5 as supported 
> for my Toshiba Satellite A40 laptop (Mobile Intel Pentium 4, 2.8GHz).
> 
> -Linux version 2.6.22-2-686 (Debian 2.6.22-4) (waldi@debian.org) ...
> +Linux version 2.6.23-rc6 (root@faramir) ...
>  [...]
> +ACPI: EC: Look up EC in DSDT
>  ACPI: Interpreter enabled
> -ACPI: (supports S0 S3 S4 S5)
> +ACPI: (supports S0 S3)
>  ACPI: Using IOAPIC for interrupt routing
>  ACPI: PCI Root Bridge [PCI0] (0000:00)
> 
> I see no other relevant changes in dmesg (full output below).
> 
> Is this a regression or expected?

Unexpected, and potentially pretty serious. Something went wrong with
ACPI. Can you try to narrow down when it started happening?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
