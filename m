From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI: EC: evaluating _Q10
Date: Tue, 2 Jan 2007 22:41:05 -0500
Message-ID: <200701022241.05303.lenb@kernel.org>
References: <45992109.9050009@m3y3r.de> <200701021205.07817.lenb@kernel.org> <459AC146.9020804@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58389 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbXACDlz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jan 2007 22:41:55 -0500
In-Reply-To: <459AC146.9020804@m3y3r.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> > The bigger question is why you get "tons of these" --
> > as EC  events are usually infrequent.
> > Do you have a big number next to "acpi" in /proc/interrupts?
> > If so, at what rate is it growing?
> 
> maybe tons were a bit to overstated... After a fresh reboot, i count 110 
> _q10 and one _q21messages now with 8 min. uptime and around 10300 acpi 
> interrupts.

480 sec/110 ec events = 4 seconds/event.  This doesn't worry me.
Could be battery updates, thermal updates etc.

480/10300 = an interrupt every 46 ms.
This is certainly not right.
Have you always seen runaway acpi interrupts on this box, no matter the kernel?

thanks,
-Len

