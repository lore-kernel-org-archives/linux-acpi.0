From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC][PATCH 1/9] ACPI: Introduce acpi_bus_power_manageable function
Date: Tue, 24 Jun 2008 14:25:06 +0200
Message-ID: <20080624122506.GC5642@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200146.30752.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2582 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756831AbYFZISt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:18:49 -0400
Content-Disposition: inline
In-Reply-To: <200806200146.30752.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Fri 2008-06-20 01:46:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI: Introduce acpi_bus_power_manageable function
> 
> Introduce function acpi_bus_power_manageable() allowing other
> (dependent) subsystems to check if ACPI is able to power manage given
> device.  This may be useful, for example, for PCI device power
> management.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
