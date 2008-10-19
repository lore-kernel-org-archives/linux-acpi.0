From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Sun, 19 Oct 2008 21:42:56 +0200
Message-ID: <200810192142.56798.rjw@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <20080911063822.973881418@sli10-desk.sh.intel.com> <200810192104.17510.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43221 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbYJSTim (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Oct 2008 15:38:42 -0400
In-Reply-To: <200810192104.17510.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, david-b@pacbell.net, dbrownell@users.sourceforge.net

On Sunday, 19 of October 2008, Rafael J. Wysocki wrote:
> On Thursday, 11 of September 2008, Shaohua Li wrote:
> > Introduce .wakeup_event(). When a device gets a wakeup event,
> > the callback is called. The callback usually should disable wakeup event.
> > 
> > ---
> >  include/linux/pm.h |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > Index: linux/include/linux/pm.h
> > ===================================================================
> > --- linux.orig/include/linux/pm.h	2008-09-11 10:56:27.000000000 +0800
> > +++ linux/include/linux/pm.h	2008-09-11 10:56:29.000000000 +0800
> > @@ -125,6 +125,12 @@ typedef struct pm_message {
> >   *	make ANY assumptions about the hardware state right prior to @restore().
> >   *	On most platforms, there are no restrictions on availability of
> >   *	resources like clocks during @restore().
> > + * @wakeup_event: Checks if a wakeup event occurs. In bus level, the op might
> > + *	check all devices under the bus and call device_receive_wakeup_event()
> > + *	for devices which invoke wakeup event. In device level, the op just
> > + *	returns if a wakeup event occurs. Note, if device follows standard
> > + *	mechanism for wakeup which bus level can handle, device level op can be
> > + *	empty.
> >   *
> >   * All of the above callbacks, except for @complete(), return error codes.
> >   * However, the error codes returned by the resume operations, @resume(),
> > @@ -151,6 +157,7 @@ struct pm_ops {
> >  	int (*thaw)(struct device *dev);
> >  	int (*poweroff)(struct device *dev);
> >  	int (*restore)(struct device *dev);
> > +	bool (*wakeup_event)(struct device *dev);
> >  };
> >  
> >  /**
> 
> I think it will be better to place wakeup_event() in 'struct device' itself
> rather than here.

That should be 'struct device_driver' actually, sorry.

Thanks,
Rafael
