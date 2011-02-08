From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] thermal: Use freezable workqueue
Date: Tue, 8 Feb 2011 10:20:25 +0100
Message-ID: <201102081020.25646.rjw@sisk.pl>
References: <201102080029.57195.rjw@sisk.pl> <20110208044712.GA906@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52659 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab1BHJUk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Feb 2011 04:20:40 -0500
In-Reply-To: <20110208044712.GA906@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>

On Tuesday, February 08, 2011, Dmitry Torokhov wrote:
> On Tue, Feb 08, 2011 at 12:29:57AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > If thermal polling is enabled, which for example is the case for
> > ACPI thermal zones with the _TZP object defined, the thermal driver
> > uses delayed work items for this purpose.  Unfortunately, since
> > they are queued up using schedule_delayed_work(), the work function
> > may be executed during system suspend or resume, which is not
> > desirable.
> > 
> > To prevent that from happening, use a freezable workqueue for
> > queuing up delayed work items in the thermal driver.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/thermal/thermal_sys.c |   22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/drivers/thermal/thermal_sys.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/thermal/thermal_sys.c
> > +++ linux-2.6/drivers/thermal/thermal_sys.c
> > @@ -62,6 +62,20 @@ static DEFINE_MUTEX(thermal_list_lock);
> >  
> >  static unsigned int thermal_event_seqnum;
> >  
> > +static struct workqueue_struct *thermal_wq;
> > +
> > +static int __init thermal_start_workqueue(void)
> > +{
> > +	thermal_wq = alloc_workqueue("thermal", WQ_FREEZEABLE, 0);
> 
> Should probably be unbound as well.

Yup, thanks.

> FWIW, I would not mind if we had a global freezeable workqueue already
> predefined. I could switch input_polldev and vmw_balloon to it and there
> probably could be more users...

Hmm, OK.

Do you think we should add system_freezeable_wq to the set of predefined
workqueues?

Rafael
