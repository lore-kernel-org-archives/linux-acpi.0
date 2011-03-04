From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] ACPI / PM: Merge do_suspend_lowlevel() into
 acpi_save_state_mem()
Date: Fri, 4 Mar 2011 16:38:50 +0100
Message-ID: <20110304153850.GG1358@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl>
 <201102072321.37565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:41056 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759765Ab1CDPi7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2011 10:38:59 -0500
Content-Disposition: inline
In-Reply-To: <201102072321.37565.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Mon 2011-02-07 23:21:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The function do_suspend_lowlevel() is specific to x86 and defined in
> assembly code, so it should be called from the x86 low-level suspend
> code rather than from acpi_suspend_enter().
> 
> Merge do_suspend_lowlevel() into the x86's acpi_save_state_mem() and
> change the name of the latter to acpi_suspend_lowlevel(), so that the
> function's purpose is better reflected by its name.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
