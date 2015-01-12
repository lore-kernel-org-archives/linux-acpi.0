From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] ACPI on arm64 TODO List
Date: Mon, 12 Jan 2015 20:39:05 +0100
Message-ID: <20150112193905.GB5281@amd>
References: <548F9668.6080900@linaro.org>
 <9355623.14GfrLxEB0@wuerfel>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
 <20150112142358.GA23680@amd>
 <CACxGe6ub0UsUNs1-2NziK_sGEtpxTjcDD+Eto3YOsNkvWxaNcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55720 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbALTjI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2015 14:39:08 -0500
Content-Disposition: inline
In-Reply-To: <CACxGe6ub0UsUNs1-2NziK_sGEtpxTjcDD+Eto3YOsNkvWxaNcw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Al Stone <al.stone@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon 2015-01-12 14:41:50, Grant Likely wrote:
> On Mon, Jan 12, 2015 at 2:23 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Sat 2015-01-10 14:44:02, Grant Likely wrote:
> >> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
> >> > On Tue, Dec 16, 2014 at 11:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> On Monday 15 December 2014 19:18:16 Al Stone wrote:
> >> >>> 7. Why is ACPI required?
> >> >>>    * Problem:
> >> >>>      * arm64 maintainers still haven't been convinced that ACPI is
> >> >>>        necessary.
> >> >>>      * Why do hardware and OS vendors say ACPI is required?
> >> >>>    * Status: Al & Grant collecting statements from OEMs to be posted
> >> >>>      publicly early in the new year; firmware summit for broader
> >> >>>      discussion planned.
> >> >>
> >> >> I was particularly hoping to see better progress on this item. It
> >> >> really shouldn't be that hard to explain why someone wants this feature.
> >> >
> >> > I've written something up in as a reply on the firmware summit thread.
> >> > I'm going to rework it to be a standalone document and post it
> >> > publicly. I hope that should resolve this issue.
> >>
> >> I've posted an article on my blog, but I'm reposting it here because
> >> the mailing list is more conducive to discussion...
> >>
> >> http://www.secretlab.ca/archives/151
> >
> > Unfortunately, I seen the blog post before the mailing list post, so
> > here's reply in blog format.
> >
> > Grant Likely published article about ACPI and ARM at
> >
> > http://www.secretlab.ca/archives/151
> >
> > . He acknowledges systems with ACPI are harder to debug, but because
> > Microsoft says so, we have to use ACPI (basically).
> 
> Please reread the blog post. Microsoft is a factor, but it is not the
> primary driver by any means.

Ok, so what is the primary reason? As far as I could tell it is
"Microsoft wants ACPI" and "hardware people want Microsoft" and
"fragmentation is bad so we do ACPI" (1) (and maybe "someone at RedHat
says they want ACPI" -- but RedHat people should really speak for
themselves.)

You snipped quite a lot of reasons why ACPI is inferior that were
below this line in email.

									Pavel

(1) ignoring fact that it causes fragmentation between servers and phones.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
