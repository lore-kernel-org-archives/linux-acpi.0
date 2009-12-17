From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop - switch from workqueue to a timer
Date: Fri, 18 Dec 2009 07:46:09 +0900
Message-ID: <20091217224609.GB13295@kamineko.org>
References: <20091217080907.GA12790@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:37479
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964889AbZLQWqM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2009 17:46:12 -0500
Content-Disposition: inline
In-Reply-To: <20091217080907.GA12790@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, Dec 17, 2009 at 12:09:07AM -0800, Dmitry Torokhov wrote:
> The function that is executing in workqueue context does not need
> to sleep so let's switch to a timer which is more lightweight.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> Mattia,
> 
> After looking at the sony-laptop driver again I realized that since
> we don't sleep in do_sony_laptop_release_key() we don't need to use
> workqueue but can simply fire up a timer.
> 
> Please consider applying (or maybe folding into the other patch
> removing private workqueue).

Hi Dmitry,

it looks like there is a bit of other clean-ups here and there included
in this patch, do you mind if I split it (or sending two separate
patches if you get around it before I do this weekend)?

Thanks
-- 
mattia
:wq!
