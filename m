From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] ACPI Suspend: Enable ACPI during resume if SCI_EN is
	not set
Date: Wed, 8 Oct 2008 13:39:34 +0200
Message-ID: <20081008113933.GC1651@ucw.cz>
References: <200810040005.06220.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40698 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753167AbYJHQqZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 12:46:25 -0400
Content-Disposition: inline
In-Reply-To: <200810040005.06220.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Renninger <trenn@suse.de>

On Sat 2008-10-04 00:05:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI Suspend: Enable ACPI during resume if SCI_EN is not set
> 
> On some machines, like for example MSI Wind U100, the BIOS doesn't
> enable ACPI before returning control to the OS, which sometimes
> causes resume to fail.  This is against the ACPI specification,
> which clearly states that "When the platform is waking from an S1, S2
> or S3 state, OSPM assumes the hardware is already in the ACPI mode
> and will not issue an ACPI_ENABLE", but it won't hurt to check the
> SCI_EN bit and enable ACPI during resume from S3 if this bit is not
> set.
> 
> Fortunately, we already have acpi_enable() for that, so use it in the
> resume code path, before executing _BFS, in analogy with the
> resume-from-hibernation code path.
> 
> NOTE: We aren't supposed to set SCI_EN directly, because it's owned
> by the hardware.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
