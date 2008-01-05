From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 19:26:33 +0100
Message-ID: <200801051926.33641.rjw@sisk.pl>
References: <20080104144238.GA5176@zoy.org> <200801051107.14677.carlos@strangeworlds.co.uk> <20080105145539.GE16376@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57193 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756081AbYAESYR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 13:24:17 -0500
In-Reply-To: <20080105145539.GE16376@zoy.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Saturday, 5 of January 2008, Michel Lespinasse wrote:
> On Sat, Jan 05, 2008 at 11:07:14AM +0000, Carlos Corbacho wrote:
> > On Saturday 05 January 2008 07:20:22 Michel Lespinasse wrote:
> > > No luck. The system still does not suspend after applying the patch set.
> > > Still stuck at the same place, "Suspending console(s)"...
> > 
> > Can you try applying this patch on top of Rafael's patch series:
> > 
> > http://files.strangeworlds.co.uk/acpi-force-1.0-suspend-behaviour
> 
> Nice !
> 
> The patch did not work as you sent it, but doing the same in acpi_pm_open()
> (i.e. forcing it to execute the revision<3 code) worked.
> I'm now doing a happy dance :)
> 
> So what now, do you need some kind of signature for the system ?
> (I realize that would probably be some kind of DMI string,
> but I'm not sure where/how to obtain it)

Well, I think I'd rather want to introduce a boot parameter for that.  Stay
tuned.

Greetings,
Rafael
