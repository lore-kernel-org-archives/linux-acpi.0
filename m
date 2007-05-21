From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/4] swsusp: Remove incorrect code from user.c
Date: Tue, 22 May 2007 01:29:04 +0200
Message-ID: <20070521232904.GJ10714@elf.ucw.cz>
References: <200705180019.35548.rjw@sisk.pl> <200705180021.21953.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48786 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755817AbXEUX3L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 19:29:11 -0400
Content-Disposition: inline
In-Reply-To: <200705180021.21953.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <aystarik@gmail.com>, Johannes Berg <johannes@sipsolutions.net>

On Fri 2007-05-18 00:21:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make the code hibernation code in kernel/power/user.c be functionally equivalent
> to the corresponding code in kernel/power/disk.c , as it should be.
> 
> The calls to the platform functions removed by this patch are incorrect.  They
> should be replaced with some other "platform" operations that will be
> introduced in one of the subsequent patches.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
