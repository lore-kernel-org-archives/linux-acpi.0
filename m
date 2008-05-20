From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 7/7] ACPI PM: Add possibility to change suspend sequence
Date: Tue, 20 May 2008 17:20:11 +0200
Message-ID: <20080520152011.GB2067@elf.ucw.cz>
References: <200805200129.19904.rjw@sisk.pl> <200805200141.58518.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54934 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbYETPTN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 May 2008 11:19:13 -0400
Content-Disposition: inline
In-Reply-To: <200805200141.58518.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>

On Tue 2008-05-20 01:41:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> There are some systems out there that don't work correctly with
> our current suspend/hibernation code ordering.  Provide a workaround
> for these systems allowing them to pass the
> 'acpi_old_suspend_ordering' command line parameter to the kernel that
> will make it use the pre-ACPI 2.0 suspend code ordering.

Command line option is now  acpi_sleep=old_ordering, but I guess that
does not matter much.

Thanks for the patch!
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
