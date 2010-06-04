From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [Intel-gfx] [RFC PATCH 0/2] i915 brightness control
Date: Sat, 05 Jun 2010 03:47:39 +0800
Message-ID: <1275680859.1828.1161.camel@laptop>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com>
	 <AANLkTiktSDWqHg_A8V5_jQsCf1w4k5x9Q7ZOCjAIZTEH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:60519 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0FDTrq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:47:46 -0400
In-Reply-To: <AANLkTiktSDWqHg_A8V5_jQsCf1w4k5x9Q7ZOCjAIZTEH@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: Kamal Mostafa <kamal@canonical.com>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Thu, 2010-06-03 at 00:20 +0100, Pedro Ribeiro wrote:
> On 2 June 2010 23:11, Kamal Mostafa <kamal@canonical.com> wrote:
> > Requesting comments on this idea (proposed by Matthew Garrett) and my
> > implementation.  Note especially the KNOWN PROBLEM with a "GM45" GPU.
> >
> >  -Kamal
> >
> > .......
> >
> > BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/568611
> >
> > In order to avoid the often-dysfunctional native acpi brightness control
> > methods, a new acpi_brightness_hook interface is made available.
> >
> > The i915 driver uses the new hook to take over brightness control.
> > Boot with i915.brightness=0 to disable.
> >
> > KNOWN PROBLEM:
> >  - i915 opregion brightness control silently fails on GM45 (pci-id 0x2a42)
> >
> > [RFC PATCH 1/2] acpi/video: acpi_brightness_hook API
> > [RFC PATCH 2/2] drm/i915: override acpi brightness control
> >
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > http://lists.freedesktop.org/mailman/listinfo/intel-gfx
> >
> 
> Are you sure this is a good idea to enable it by default just because
> of a problem with one manufacturer (Dell)?

This issue is with many manufactures. From this bug you can see HP
machines are effected also.

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/568611
> 
> My Lenovo laptop has fine brightness control with a GM45 and this may break it.
> Might be safer only to enable it for laptops with known problems.
> 
> 
> Regards,
> Pedro
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


