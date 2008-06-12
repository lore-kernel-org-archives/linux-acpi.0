From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH - supplement] PM: Remove remaining obsolete definitions from pm.h (was: Re: [PATCH 0/4] Remove some obsolete PM stuff)
Date: Thu, 12 Jun 2008 15:13:47 +0200
Message-ID: <20080612131347.GE5455@ucw.cz>
References: <200806121025.24668.rjw@sisk.pl> <200806121126.27862.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4199 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761984AbYFLNN7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2008 09:13:59 -0400
Content-Disposition: inline
In-Reply-To: <200806121126.27862.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thu 2008-06-12 11:26:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Remove the remaining obsolete definitions from
> include/linux/pm.h and move the definitions of PM_SUSPEND and
> PM_RESUME to the header of h3600 which is the only user of them.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.. and thanks for doing the cleanups.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
