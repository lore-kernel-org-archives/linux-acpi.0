From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC][PATCH 2/9] PCI: Introduce platform_pci_power_manageable function
Date: Tue, 24 Jun 2008 14:31:26 +0200
Message-ID: <20080624123125.GD5642@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200147.16040.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2608 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757138AbYFZITS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:19:18 -0400
Content-Disposition: inline
In-Reply-To: <200806200147.16040.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

Hi!

> +static struct pci_platform_pm_ops *pci_platform_pm;
> +
> +int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
> +{
> +	if (!ops->is_manageable || !ops->set_state || !ops->choose_state)
> +		return -EINVAL;
> +	pci_platform_pm = ops;
> +	return 0;
> +}

BUG_ON? It is programmer error if we see NULLs here, right? (And those
programmers will be exactly those not checking the return value).

Otherwise looks ok to me.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
