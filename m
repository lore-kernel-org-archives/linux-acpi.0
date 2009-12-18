From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] sony-laptop - switch from workqueue to a timer
Date: Thu, 17 Dec 2009 22:08:57 -0800
Message-ID: <20091218060857.GA21231@core.coreip.homeip.net>
References: <20091217080907.GA12790@core.coreip.homeip.net> <20091217224609.GB13295@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:44685 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZLRGJC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 01:09:02 -0500
Received: by pxi4 with SMTP id 4so2021806pxi.33
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2009 22:09:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091217224609.GB13295@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, Dec 18, 2009 at 07:46:09AM +0900, Mattia Dongili wrote:
> On Thu, Dec 17, 2009 at 12:09:07AM -0800, Dmitry Torokhov wrote:
> > The function that is executing in workqueue context does not need
> > to sleep so let's switch to a timer which is more lightweight.
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> > 
> > Mattia,
> > 
> > After looking at the sony-laptop driver again I realized that since
> > we don't sleep in do_sony_laptop_release_key() we don't need to use
> > workqueue but can simply fire up a timer.
> > 
> > Please consider applying (or maybe folding into the other patch
> > removing private workqueue).
> 
> Hi Dmitry,
> 
> it looks like there is a bit of other clean-ups here and there included
> in this patch, do you mind if I split it (or sending two separate
> patches if you get around it before I do this weekend)?
> 

Sure, sending out...

-- 
Dmitry
