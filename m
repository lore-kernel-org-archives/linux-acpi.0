From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Thu, 7 Dec 2006 21:00:59 +0100
Message-ID: <200612072101.00365.rjw@sisk.pl>
References: <E3C0BCA40296C347AF7142161DB9FC828618B8@mssmsx411> <200612072047.31473.rjw@sisk.pl> <45787015.3020909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50248 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163247AbWLGT6T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 14:58:19 -0500
In-Reply-To: <45787015.3020909@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>

On Thursday, 7 December 2006 20:48, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Thursday, 7 December 2006 19:57, Karasyov, Konstantin A wrote:
> >   
> >> Hi,
> >>
> >> Unfortunately, I cannot reproduce this bug on my system, but the problem
> >> could be solved by adding a resume handler for AC adapter device. Could
> >> you try the attached patch to see if it helps.
> >>     
> >
> > I can reproduce it and the patch doesn't help.
> >
> > Greetings,
> > Rafael
> >
> >   
> Any ACPI errors in dmesg?

Not anything noticeable except for

ACPI: Unable to turn cooling device [<an address>] 'on'

which seems to be normal on this box.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
