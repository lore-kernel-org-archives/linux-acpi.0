From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] : ACPI : Use clocksource to get the C-state time instead of ACPI PM timer
Date: Mon, 12 Jan 2009 13:27:59 +0100
Message-ID: <200901121327.59772.rjw@sisk.pl>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901120858.46440.rjw@sisk.pl> <1231752719.4026.73.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42388 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbZALM2o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jan 2009 07:28:44 -0500
In-Reply-To: <1231752719.4026.73.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: LenBrown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

On Monday 12 January 2009, Zhao Yakui wrote:
> On Mon, 2009-01-12 at 15:58 +0800, Rafael J. Wysocki wrote:
> > On Monday 12 January 2009, Zhao Yakui wrote:
> > > Subject: ACPI: Use clocksource to get the C-state time instead of ACPI PM timer
> > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > 
> > >     On most boxes the ACPI PM timer is 24-bit counter that runs on 3.579545MHz
> > > clock. In such case the max C-state sleep time should be less than 4687ms when
> > > it is used to record C2/C3 duration time. 
> > >     But on some boxes the max C-state sleep time is more than 4687ms. In such
> > > case the overflow happens and the C-state duration time can't be counted
> > > accurately.
> > >     Use clocksource to get the C-state time instead of ACPI PM timer
> > 
> > I haven't looked at the patch in detail, but what I would do would be to use
> > the ACPI PM timer by default and _if_ the results from that are not reasonable,
> > _then_ fall back to the clocksource.  Is this what you have implemented?
> 
> What you said is also OK. But it is not easy to detect whether the
> result by using ACPI PM timer is not reasonable.  If doing so, another
> clocksource(for example: hpet) should also be used in cpuidle driver and
> compared with ACPI PM timer. (Sometimes the ACPI PM timer will be used
> as the current clocksource. In such case it will be duplicated).
> 
> So the current clocksource will be used to count the C-state time
> instead of ACPI PM timer. If the current clocksource is changed by user,
> OS will select the reliable clocksource as the current one.

I understand the idea.  My point was to stick to the current behavior where
it is known to work and only change the behavior when it doesn't work.  Still,
if that is difficult to implement, the idea to always use the clocksource is
probably better than the current situation.

Of course, if it happens to introduce regressions you'll have to consider the
other approach anyway.

Thanks,
Rafael
