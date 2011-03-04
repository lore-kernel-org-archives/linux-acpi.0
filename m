From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/6] ACPI / PM: Do not switch interrupts off/on in
 acpi_hibernation_enter()
Date: Fri, 4 Mar 2011 16:39:07 +0100
Message-ID: <20110304153907.GH1358@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl>
 <201102072322.47041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:41073 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759770Ab1CDPjP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2011 10:39:15 -0500
Content-Disposition: inline
In-Reply-To: <201102072322.47041.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Mon 2011-02-07 23:22:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The function acpi_hibernation_enter() is always called with
> interrupts off, so it doesn't need to switch them off and on.

ack... and maybe comment?
							       Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
