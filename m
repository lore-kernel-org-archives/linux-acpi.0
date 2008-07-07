From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 5/8] ACPI: Introduce new device wakeup flag 'prepared'
Date: Mon, 7 Jul 2008 16:08:25 +0200
Message-ID: <20080707140825.GB23667@elf.ucw.cz>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl> <200807070334.12948.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52039 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbYGGRA0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2008 13:00:26 -0400
Content-Disposition: inline
In-Reply-To: <200807070334.12948.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

On Mon 2008-07-07 03:34:11, Rafael J. Wysocki wrote:
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
