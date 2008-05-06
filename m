From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI PM: Add suspend sequence workaround
Date: Wed, 7 May 2008 00:09:52 +0200
Message-ID: <200805070009.53120.rjw@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl> <200805062344.31117.rjw@sisk.pl> <200805062257.55554.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56615 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933179AbYEFWLi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 18:11:38 -0400
In-Reply-To: <200805062257.55554.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>

On Tuesday, 6 of May 2008, Carlos Corbacho wrote:
> On Tuesday 06 May 2008 22:44:30 Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > There are some systems out there that don't work correctly with
> > our current suspend/hibernation code ordering.  Provide a workaround
> > for these systems allowing them to pass the
> > 'acpi_old_suspend_ordering' command line parameter to the kernel that
> > will make it use the pre-ACPI 2.0 suspend code ordering.
> 
> Can we tack on a set of DMI matches to this somewhere to automatically apply 
> this to the systems we know so far that need the old ordering?

Yes, that will be the next step.

I think the command line argument may be useful anyway for checking if given
system is affected.

Thanks,
Rafael
