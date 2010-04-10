From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff - bug?
Date: Sat, 10 Apr 2010 21:36:43 +0200
Message-ID: <201004102136.43246.rjw@sisk.pl>
References: <20100401133923.GA4104@tiehlicka.suse.cz> <201004092242.17341.rjw@sisk.pl> <1270848027.3071.0.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46440 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab0DJTds (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Apr 2010 15:33:48 -0400
In-Reply-To: <1270848027.3071.0.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Michal Hocko <mhocko@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Friday 09 April 2010, Tony Vroon wrote:
> On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> > Please check if the patch below changes anything.
> >  drivers/acpi/wakeup.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> That didn't change the behaviour for me, sorry.

Well, I would be sorry if it did, because the patch removed some useful code. :-)

> (I made sure to go through a full power down session before trying the
> patched kernel)

Thanks for testing.  So it looks like we don't disable the GPE during power off.

I'll try to figure out what's going on, please stay tuned.

Rafael
