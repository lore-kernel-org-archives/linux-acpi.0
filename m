From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] does anyone have Dell Latitude E6400?
Date: Wed, 17 Jun 2009 11:39:19 +0200
Message-ID: <20090617093919.GB1403@ucw.cz>
References: <1244529861.9076.61.camel@rzhang-dt> <1244531153.9076.68.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58226 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbZFQJos (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2009 05:44:48 -0400
Content-Disposition: inline
In-Reply-To: <1244531153.9076.68.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>

On Tue 2009-06-09 15:05:53, Zhang Rui wrote:
> BTW, it would be great if someone can verify if the Macbook MB402LL/A,
> MB403LL/A, MB404LL/A has ACPI ambient light sensor or not.

Not enough people here, I guess. Try lkml?

> On Tue, 2009-06-09 at 14:44 +0800, Zhang Rui wrote:
> > Hi, all,
> > 
> > I need to purchase a laptop with ambient light sensor to implement the
> > ACPI ambient light sensor driver in Linux.
> > Google tells me that Dell Latitude e6400 has this, but I'm not sure if
> > the sensor is controlled via ACPI or platform specific methods.
> > so can anybody that has this laptop send me the lspci and acpidump
> > output please?
> > 
> > If somebody knows some other laptop models with this ACPI device (grep
> > ACPI0008 and _ALI/_ALR control methods in the acpidump), please let me
> > know.
> > 
> > BTW, to get the acpidump output, you need to download the latest pmtools
> > at http://www.lesswatts.org/projects/acpi/utilities.php,
> > build and run "acpidump > acpidump.log".
> > 
> > thanks,
> > rui
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
