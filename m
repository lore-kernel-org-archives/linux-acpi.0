From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 04/11] ACPI: Introduce acpi_device_sleep_wake function
Date: Mon, 7 Jul 2008 09:18:22 +0200
Message-ID: <20080707071822.GE5643@ucw.cz>
References: <200806231934.08565.rjw@sisk.pl> <200806231945.39951.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2449 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751380AbYGHNiQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 09:38:16 -0400
Content-Disposition: inline
In-Reply-To: <200806231945.39951.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Mon 2008-06-23 19:45:39, Rafael J. Wysocki wrote:
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
