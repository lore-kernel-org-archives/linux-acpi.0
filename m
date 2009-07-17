From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Fri, 17 Jul 2009 09:37:00 +0800
Message-ID: <1247794620.26272.213.camel@rzhang-dt>
References: <1247643512.26272.74.camel@rzhang-dt>
	 <87ocrm6xeq.fsf@basil.nowhere.org> <1247710483.26272.170.camel@rzhang-dt>
	 <20090716114020.GA11928@khazad-dum.debian.net>
	 <4A5F2EEC.8010508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53858 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933931AbZGQBgS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 21:36:18 -0400
In-Reply-To: <4A5F2EEC.8010508@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, 2009-07-16 at 21:45 +0800, Arjan van de Ven wrote:
> Henrique de Moraes Holschuh wrote:
> > On Thu, 16 Jul 2009, Zhang Rui wrote:
> >> the kernel device suspend time is reduced from 3.2s to 2.8s after
> >> applying this patch set in my test box.
> > 
> > It will give even a bigger boot time saving on ThinkPads, where there is a
> > Synaptics (or ALPS if you are unlucky) touchpad with the trackpoint behind
> > it... it takes about 2s to init both devices here.  That's two seconds of
> > boot time you can shove off if it is being initialized assyncronously :-)
> > 
> 
> that's a different problem that I don't think this will solve;

right.
we are not able to get an async device group during initialization.

thanks,
rui

>  as long
> as you keep the boot of the kernel wait for all async actions, you're going
> to hit that wait. In Moblin we have a (bad) patch to not do the wait,
> at some point we need to figure how to get a mainline-able patch....

