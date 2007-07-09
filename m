From: Richard Hughes <hughsient@gmail.com>
Subject: Re: Hibernate after alarm wakes from STR
Date: Mon, 09 Jul 2007 09:34:11 +0100
Message-ID: <1183970051.3087.5.camel@work>
References: <20070330235759.GC4252@cosmic.amd.com>
	 <200707081315.40560.david-b@pacbell.net> <20070708223121.GB4964@dmt>
	 <200707081944.04598.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:39610 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXGIIgz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 04:36:55 -0400
Received: by wx-out-0506.google.com with SMTP id h31so790733wxd
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jul 2007 01:36:54 -0700 (PDT)
In-Reply-To: <200707081944.04598.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-pm@lists.linux-foundation.org, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org

On Sun, 2007-07-08 at 19:44 -0700, David Brownell wrote:
> On Sunday 08 July 2007, Marcelo Tosatti wrote:
> > On Sun, Jul 08, 2007 at 01:15:40PM -0700, David Brownell wrote:
> > > On Sunday 08 July 2007, Richard Hughes wrote:
> > > 
> > > That is, we may want to provide a bit more information about the
> > > specific event which triggered wakeup.  I don't believe there is
> > > such an interface, in general.
> > 
> > What would be a nice interface? Perhaps an additional file under
> > /sys/devices/.../power/wakeup_fired or something (only for devices with
> > can_wakeup set).
> 
> Better a /sys/power/wakeup_event (or whatever) that's more easily
> found.  It could link to the device issuing the event.

Good plan.

> > > Plus, the notion seems kind of racey to me.  (If you press a key
> > > right while the wakealarm fires, you don't want hibernation..)
> > 
> > Then you check if the any key or other wakeup event has happened other
> > than RTC... I don't see any problem with that.
> 
> It might be best not to need to re-activate the whole system from
> STR though ... it ought to be possible to just power off, having
> already written the image to disk.  Right?
> 
> Yes, there's all that stuff about how to quiesce the system properly,
> freezer/icebox/flamesuits/etc.  Regardless, going from STR to fully
> operational and then hibernating would take time and energy that
> might not be available...

Sure, although quick-suspend on a few minutes idle, slow
hibernate-on-long idle is one of the biggest requested features of
g-p-m.

Richard.


