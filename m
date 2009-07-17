From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/4] drm/i915: use ACPI LID status for LVDS
	->detect hook
Date: Fri, 17 Jul 2009 09:44:11 +0800
Message-ID: <1247795051.4113.76.camel@localhost.localdomain>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
	 <1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
	 <1247709284.4113.50.camel@localhost.localdomain>
	 <20090716093217.431e733b@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26974 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933497AbZGQBnX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 21:43:23 -0400
In-Reply-To: <20090716093217.431e733b@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-07-17 at 00:32 +0800, Jesse Barnes wrote:
> On Thu, 16 Jul 2009 09:54:44 +0800
> ykzhao <yakui.zhao@intel.com> wrote:
> 
> > On Thu, 2009-07-16 at 06:11 +0800, Jesse Barnes wrote:
> > > We can't load or hotplug detect LVDS like we can other outputs, but
> > > if there's a lid device present we can use it as a proxy.  This
> > > allows the LFP state to be determined at ->detect time, making
> > > configurations requiring manual intervention today "just work"
> > > assuming the lid device status is correct.
> > It is ok that the LID status is to decide whether the LVDS is
> > connected/disconnected.
> > 
> > But on some boxes the initial LID status is incorrect. It reports that
> > LID is closed although it is open.
> >     For example: 
> >     http://bugzilla.kernel.org/show_bug.cgi?id=5809
> >     http://bugzilla.kernel.org/show_bug.cgi?id=13263
> >     http://bugzilla.kernel.org/show_bug.cgi?id=5904
> >     https://bugs.launchpad.net/ubuntu/+bug/34389
> > Maybe this feature is not supported on the above laptops. That means
> > that LVDS is always connected regardless of LID status.
> > 
> > At the same time on some boxes there is no ACPI LID event when the LID
> > is reopened. In such case we can't send the hotplug event to user
> > space when the LID is reopened. How about disable this feature on
> > such box? For example: Aspire One.
> > 
> > 
> > I have another issue about the hotplug event.
> > On some boxes it will continue to report the LID event  when the LID
> > is closed. In such case we had better not send the hotplug event to
> > user space. Otherwise the user space will receive too many hotplug
> > event about LVDS. For example:
> >      http://bugzilla.kernel.org/show_bug.cgi?id=10485
> >      http://bugzilla.kernel.org/show_bug.cgi?id=5853
> > 
> > So it will be better that the feature of hotplug/LID status is not
> > supported on such boxes.
> 
> Yeah those are all good points; thanks for the list of bugs.  Any
> suggestions on how to do a blacklist?  Is there an ACPI or DMI
> identifier we could use?
How about not register the lid notifier callback function for the boxes
that fall into the backlist?
And the LVDS detection will always return connected when there is no LID
notifier callback.

Sorry that there is no dmidecode for the above laptops. I will ask the
bug reporter to attach them.

Thanks.
   Yakui
> 

