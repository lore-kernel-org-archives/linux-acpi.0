From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 23/37] Suspend: Clean up Kconfig (V2)
Date: Mon, 4 Feb 2008 14:59:32 +0000
Message-ID: <20080204145932.GA8004@ucw.cz>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com> <9a72d19a83ff28dd65eae54e210a9141ad993e88.1201840183.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1064 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750981AbYBDO7m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 09:59:42 -0500
Content-Disposition: inline
In-Reply-To: <9a72d19a83ff28dd65eae54e210a9141ad993e88.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

On Thu 2008-01-31 23:36:54, Len Brown wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> 
> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Russell King <rmk@arm.linux.org.uk>
> Acked-by: Paul Mackerras <paulus@samba.org>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> Cc: Pavel Machek <pavel@suse.cz>

ACK.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
