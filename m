From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 4/4] PCI ACPI: Drop the second argument of
	platform_pci_choose_state
Date: Wed, 7 May 2008 11:24:11 +0200
Message-ID: <20080507092411.GC13858@elf.ucw.cz>
References: <200805062331.39454.rjw@sisk.pl> <200805062338.42587.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44149 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbYEGJX1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2008 05:23:27 -0400
Content-Disposition: inline
In-Reply-To: <200805062338.42587.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Shaohua Li <shaohua.li@intel.com>, David Brownell <david-b@pacbell.net>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Tue 2008-05-06 23:38:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since the second argument of acpi_pci_choose_state() and
> platform_pci_choose_state() is never used, so remove it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
