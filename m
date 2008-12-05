From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression in 2.6.28-rc and 2.6.27-stable - hibernate related
Date: Fri, 5 Dec 2008 01:24:29 +0100
Message-ID: <200812050124.29958.rjw@sisk.pl>
References: <b637ec0b0811230817x5b445a0m665305d2b6bf6c1f@mail.gmail.com> <b637ec0b0811270717t360ce5f9j3d48e8a007010b0e@mail.gmail.com> <b637ec0b0811271354l58fc6039m941ca37fb9173d5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53601 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbYLEAY5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Dec 2008 19:24:57 -0500
In-Reply-To: <b637ec0b0811271354l58fc6039m941ca37fb9173d5b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jay Fenlason <fenlason@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rui.zhang@intel.com

(CCing to linux-acpi at Rui's request)

On Thursday, 27 of November 2008, Fabio Comolli wrote:
> Hi
> 
> On Thu, Nov 27, 2008 at 4:17 PM, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> > Hi
> >
> > On Thu, Nov 27, 2008 at 12:02 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> Actually, yes, Fabio, you can try to revert all of the "ACPI: EC:" commits
> >> applied after 2.6.27.4 and retest.
> >
> > Will do tonight. I see that there are some other "ACPI: EC:" commits
> > in 2.6.27.6 and 2.6.27.7.
> >
> > I'l just compile the ec.c file from 2.6.27.4 in 2.6.27.7 and test if
> > the three commits introduced in 2.6.27.5 wouldn't revert cleanly,
> >
> > By the way, my HD passed a "smartctl -t long" test without any problems.
> >
> 
> Reproduced with 2.6.27.7 with ec.c taken from 2.6.27.4 - after three
> minutes of freeze the laptop came back to normal as nothing had
> happened.
