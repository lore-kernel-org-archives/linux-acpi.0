From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC][PATCH 3/9] PCI: Rework pci_set_power_state function
Date: Tue, 24 Jun 2008 14:34:55 +0200
Message-ID: <20080624123454.GE5642@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200148.24365.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2568 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756518AbYFZISk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:18:40 -0400
Content-Disposition: inline
In-Reply-To: <200806200148.24365.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Fri 2008-06-20 01:48:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI: Rework pci_set_power_state function
> 
> Rework pci_set_power_state() so that the platform callback is
> invoked before the native mechanism, if necessary.  Also, make
> the function check if the device is power manageable by the
> platform before invoking the platform callback.
> 
> This may matter if the device dependent on additional power
> resources controlled by the platform is being put into D0, in which
> case those power resources must be turned on before we attempt to
> handle the device itself. 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks ok to me. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
