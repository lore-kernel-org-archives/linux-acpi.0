From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 10/11] PCI PM: Introduce pci_prepare_to_sleep and pci_back_from_sleep
Date: Mon, 7 Jul 2008 09:02:47 +0200
Message-ID: <20080707070247.GA5643@ucw.cz>
References: <200806231934.08565.rjw@sisk.pl> <200806231945.00404.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2469 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751656AbYGHNip (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 09:38:45 -0400
Content-Disposition: inline
In-Reply-To: <200806231945.00404.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Mon 2008-06-23 19:44:59, Rafael J. Wysocki wrote:
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

Looks ok to me, ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
