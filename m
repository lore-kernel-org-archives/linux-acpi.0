From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/4] Remove references to struct pm_dev from IRDA headers
Date: Thu, 12 Jun 2008 15:09:40 +0200
Message-ID: <20080612130939.GB5455@ucw.cz>
References: <200806121025.24668.rjw@sisk.pl> <200806121029.30961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4179 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759026AbYFLNKK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2008 09:10:10 -0400
Content-Disposition: inline
In-Reply-To: <200806121029.30961.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Samuel Ortiz <samuel@sortiz.org>

On Thu 2008-06-12 10:29:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Some IRDA headers contain references to 'struct pm_dev' that are not
> necessary any more and may be removed.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
