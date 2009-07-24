From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 1/4] fix a problem that linux/async.h can not be
	included in another header file
Date: Fri, 24 Jul 2009 09:12:07 +0200
Message-ID: <20090724071207.GA10760@elf.ucw.cz>
References: <1248404520.2670.109.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58935 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbZGXHMO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2009 03:12:14 -0400
Content-Disposition: inline
In-Reply-To: <1248404520.2670.109.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Fri 2009-07-24 11:02:00, Zhang Rui wrote:
> 
> include/linux/async.h:16: error: redefinition of typedef ???async_cookie_t???
> include/linux/async.h:16: error: previous declaration of ???async_cookie_t??? was here
> include/linux/async.h:17: error: redefinition of typedef ???async_func_ptr???
> include/linux/async.h:17: error: previous declaration of ???async_func_ptr??? was here
> 
> fix a problem that include/linux/async.h can not be included in another header file
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
