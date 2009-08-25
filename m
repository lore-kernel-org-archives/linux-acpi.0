From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V4 2/2] introduce ACPI ALS device driver
Date: Tue, 25 Aug 2009 10:46:01 +0200
Message-ID: <20090825084601.GM29763@elf.ucw.cz>
References: <1251184696.3483.96.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40351 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZHYIqG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2009 04:46:06 -0400
Content-Disposition: inline
In-Reply-To: <1251184696.3483.96.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue 2009-08-25 15:18:16, Zhang Rui wrote:
> ???ACPI spec defines ACPI Ambient Light Sensor device (hid ACPI0008),
> which provides a standard interface by which the OS may query properties
> of the ambient light environment the system is currently operating in,
> as well as the ability to detect meaningful changes in these values when
> the environment changes.
> 
> This patch introduces the ACPI ALS device driver.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

ACK... and thanks for patience.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
