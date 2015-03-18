From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] gpio / ACPI: Two minor cleanups related to ACPI_HANDLE()
Date: Wed, 18 Mar 2015 15:37:40 +0100
Message-ID: <6725830.XiW3NgVMmi@vostro.rjw.lan>
References: <4032246.STUT1iRmIk@vostro.rjw.lan> <3557241.dRi1Xkn3WC@vostro.rjw.lan> <CAAVeFu+a6HVKaB7-4CHqgK50uAtzE6tt_bTWYaNUP55o8xA0Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53088 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932958AbbCRONp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2015 10:13:45 -0400
In-Reply-To: <CAAVeFu+a6HVKaB7-4CHqgK50uAtzE6tt_bTWYaNUP55o8xA0Qg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wednesday, March 18, 2015 10:47:30 AM Alexandre Courbot wrote:
> On Wed, Mar 18, 2015 at 10:37 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, March 10, 2015 11:07:36 PM Rafael J. Wysocki wrote:
> >> Hi,
> >>
> >> As per the subject, avoid evaluating ACPI_HANDLE() if we can as that one is
> >> rather costly.
> >
> > Linus, Alexandre, any objections to this series?
> >
> > If not, would there be any problem if I took these to my tree?  I'll probably
> > have material on top of them.
> 
> Sorry for the delay. Looks like Linus just took the patches in his
> tree, I hope that's ok?

Yes, that's fine, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
