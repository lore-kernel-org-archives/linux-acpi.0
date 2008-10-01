From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] thermal: Make it simpler to use the thermal layer
	inside the kernel
Date: Wed, 1 Oct 2008 14:41:48 +0200
Message-ID: <20081001124148.GA7261@elf.ucw.cz>
References: <20081001120420.GA29479@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51820 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbYJAMla (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 08:41:30 -0400
Content-Disposition: inline
In-Reply-To: <20081001120420.GA29479@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com

Hi!

> The thermal layer passes temperatures and trip point types around as 
> strings. This is fine for sysfs, but makes it hard to use them for other 
> purposes in-kernel. Move the string conversion to the sysfs-specific 
> code.

Makes sense.

> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Pavel Machek <pavel@suse.cz>

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
