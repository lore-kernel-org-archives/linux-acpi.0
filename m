From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] ACPI / PM: Drop acpi_restore_state_mem()
Date: Fri, 4 Mar 2011 16:35:55 +0100
Message-ID: <20110304153555.GA1358@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl>
 <201102072318.02829.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:37776 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759480Ab1CDPgG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2011 10:36:06 -0500
Content-Disposition: inline
In-Reply-To: <201102072318.02829.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

On Mon 2011-02-07 23:18:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The function acpi_restore_state_mem() has never been and most likely
> never will be used, so remove it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
