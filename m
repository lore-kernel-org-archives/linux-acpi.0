From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC][PATCH 4/9] ACPI: Introduce acpi_device_sleep_wake function
Date: Tue, 24 Jun 2008 14:38:53 +0200
Message-ID: <20080624123852.GF5642@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200149.31090.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2578 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756749AbYFZIS6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2008 04:18:58 -0400
Content-Disposition: inline
In-Reply-To: <200806200149.31090.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Fri 2008-06-20 01:49:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI: Introduce acpi_device_sleep_wake function
> 
> The currect ACPI code attempts to execute _PSW at three different
> places and in one of them only it tries to execute _DSW before _PSW,
> which is inconsistent with the other two cases.
> 
> Move the execution of _DSW and _PSW into a separate function called
> acpi_device_sleep_wake() and call it wherever appropriate instead of
> executing _DSW and/or _PSW directly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
