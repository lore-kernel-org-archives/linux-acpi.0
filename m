From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 7/8] PCI PM: Introduce pci_prepare_to_sleep and
	pci_back_from_sleep
Date: Fri, 11 Jul 2008 22:31:33 +0200
Message-ID: <20080711203133.GC6843@elf.ucw.cz>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl> <200807070335.27309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41139 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYGKUbA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jul 2008 16:31:00 -0400
Content-Disposition: inline
In-Reply-To: <200807070335.27309.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

On Mon 2008-07-07 03:35:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI PM: Introduce pci_prepare_to_sleep and pci_back_from_sleep
> 
> Introduce functions pci_prepare_to_sleep() and pci_back_from_sleep(),
> to be used by the PCI drivers that want to place their devices into
> the lowest power state appropiate for them (PCI_D3hot, if the device
> is not supposed to wake up the system, or the deepest state from
> which the wake-up is possible, otherwise) while the system is being
> prepared to go into a sleeping state and to put them back into D0
> during the subsequent transition to the working state.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
