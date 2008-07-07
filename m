From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 02/11] PCI: Introduce platform_pci_power_manageable function
Date: Mon, 7 Jul 2008 09:05:08 +0200
Message-ID: <20080707070508.GC5643@ucw.cz>
References: <200806231934.08565.rjw@sisk.pl> <200806231945.26068.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2489 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753716AbYGHNix (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 09:38:53 -0400
Content-Disposition: inline
In-Reply-To: <200806231945.26068.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Mon 2008-06-23 19:45:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI: Introduce platform_pci_power_manageable function
> 
> Introduce function pointer platform_pci_power_manageable to be used
> by the platform-related code to point to a function allowing us to
> check if given device is power manageable by the platform.
> 
> Introduce acpi_pci_power_manageable() playing that role for ACPI.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
