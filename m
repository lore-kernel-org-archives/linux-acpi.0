From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 05/11] ACPI: Introduce new device wakeup flag 'prepared'
Date: Mon, 7 Jul 2008 09:20:19 +0200
Message-ID: <20080707072019.GF5643@ucw.cz>
References: <200806231934.08565.rjw@sisk.pl> <200806231945.47937.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2492 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753731AbYGHNiz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 09:38:55 -0400
Content-Disposition: inline
In-Reply-To: <200806231945.47937.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Mon 2008-06-23 19:45:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI: Introduce new device wakeup flag 'prepared'
> 
> Introduce additional flag 'prepared' in
> struct acpi_device_wakeup_flags and use it to prevent devices from
> being enable/disabled do wake up the system multiple times in a row
> (this does not happen currently, but will be possible after some of
> the following patches).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
