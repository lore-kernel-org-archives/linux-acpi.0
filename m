From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 2/7] acpi_pm_device_sleep_state() cleanup
Date: Mon, 24 Mar 2008 17:30:46 +0100
Message-ID: <20080324163045.GB4206@ucw.cz>
References: <200803201408.33466.david-b@pacbell.net> <200803201410.57801.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3846 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754823AbYCYOmx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 10:42:53 -0400
Content-Disposition: inline
In-Reply-To: <200803201410.57801.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Thu 2008-03-20 14:10:57, David Brownell wrote:
> Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The
> only legitimate value of that parameter must be derived from the first
> parameter, which is what all the callers already do.  (However, this
> does not address the fact that ACPI still doesn't set up those flags.)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

ACK, FWIW.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
