From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] thermal: Use freezable workqueue
Date: Tue, 8 Feb 2011 10:32:12 +0100
Message-ID: <20110208093212.GA6558@htj.dyndns.org>
References: <201102080029.57195.rjw@sisk.pl>
 <20110208044712.GA906@core.coreip.homeip.net>
 <201102081020.25646.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201102081020.25646.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Hello, Dmitry, Rafael.

On Tue, Feb 08, 2011 at 10:20:25AM +0100, Rafael J. Wysocki wrote:
> > > +	thermal_wq = alloc_workqueue("thermal", WQ_FREEZEABLE, 0);
> > 
> > Should probably be unbound as well.
> 
> Yup, thanks.

Hmm.. why should it be unbound?  Unbound wqs are primarily useful for
very long running (system daemon type) works which may also consume
considerable amount of cpu cycles.

> > FWIW, I would not mind if we had a global freezeable workqueue already
> > predefined. I could switch input_polldev and vmw_balloon to it and there
> > probably could be more users...
> 
> Hmm, OK.
> 
> Do you think we should add system_freezeable_wq to the set of predefined
> workqueues?

Oh, yeah, definitely.  I'll write up a patch.

Thanks.

-- 
tejun
