From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 3 Dec 2006 13:11:24 +0000
Message-ID: <20061203131124.GG4773@ucw.cz>
References: <200612031526.00861.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10249 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1759663AbWLCNLq
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Dec 2006 08:11:46 -0500
Content-Disposition: inline
In-Reply-To: <200612031526.00861.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> I started to notice it some time ago; I can't say exactly if this was not 
> present in earlier versions because recently I switched from STR (which gave 
> me no end of troubles) to STD. So I may have not seen it before.
> 
> Suspend to disk while on battery. Plug in AC, resume. ACPI continues to show 
> AC adapter as not present:
> 
> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> state:                   off-line
> 
> replugging AC correctly changes state to on-line.

try echo platform > /sys/power/disk.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
