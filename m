From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of
	I/O devices
Date: Wed, 24 Jun 2009 17:04:00 +0200
Message-ID: <20090624150400.GG1784@ucw.cz>
References: <200906140023.36147.rjw@sisk.pl> <200906141158.50171.rjw@sisk.pl> <200906150057.32424.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756079AbZF0L2f@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200906150057.32424.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
List-Id: linux-acpi@vger.kernel.org

Hi!


> +2. Run-time PM Helper Functions and Device Fields
> +
> +The following helper functions are defined in drivers/base/power/runtime.c
> +and include/linux/pm_runtime.h:
> +
> +* void pm_runtime_init(struct device *dev);
> +* void pm_runtime_enable(struct device *dev);
> +* void pm_runtime_disable(struct device *dev);
> +* int pm_runtime_suspend(struct device *dev);
> +* void pm_request_suspend(struct device *dev, unsigned long delay);
> +* int pm_runtime_resume(struct device *dev);
> +* void pm_request_resume(struct device *dev);
> +* void pm_cancel_runtime_suspend(struct device *dev);
> +* void pm_cancel_runtime_resume(struct device *dev);
> +* void pm_suspend_check_children(struct device *dev, bool enable);

Those *s look confusingly like pointers. Remove them?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
