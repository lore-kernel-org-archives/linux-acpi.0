From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3] PM: Do not destroy/create devices while suspended
	in cpuid.c
Date: Tue, 25 Dec 2007 13:34:08 +0100
Message-ID: <20071225123408.GD1670@elf.ucw.cz>
References: <200712240155.14765.rjw@sisk.pl> <200712240157.58560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36781 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753587AbXLYMfx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Dec 2007 07:35:53 -0500
Content-Disposition: inline
In-Reply-To: <200712240157.58560.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

On Mon 2007-12-24 01:57:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The cpuid driver should not attempt to destroy/create a suspended
> device.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
