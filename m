From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 0/3] pm: device parallel resume mechanism
Date: Mon, 22 Dec 2008 11:12:02 +0800
Message-ID: <1229915522.562.164.camel@rzhang-dt>
References: <1229668448.562.88.camel@rzhang-dt>
	 <200812191815.11153.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23489 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbYLVDNp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Dec 2008 22:13:45 -0500
In-Reply-To: <200812191815.11153.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>

Hi, rafael=20

On Sat, 2008-12-20 at 01:15 +0800, Rafael J. Wysocki wrote:
> On Friday, 19 of December 2008, Zhang Rui wrote:
> > Hi, all,
> >=20
> > =EF=BB=BFThe resume process can be split into 3 parts, BIOS resume =
time, kernel
> > resume time and X/application resume time.
> > And device resume takes most of the kernel resume time.
> > this patch set introduces a new mechanism to resume device in paral=
lel
> > which can reduce the device resume time a lot.
> >=20
> > In this proposal, some devices can create its own workqueue for
> > parallel resume. And for all the other devices that depends on this
> > device, their resume methods are queued in the same workqueue.
> > And we flush all the workqueues before resuming X/applications.
> >=20
> > As the devices vary from different platforms. it's hard to give an =
exact
> > number of how much time it can reduce.
> > Here are some of my test results:
> > 1. eeepc901, kernel resume time can be reduced from about 2.1 secon=
ds to
> > 1.6 seconds.
> > 2. a SantaRosa testbox, kernel resume time can be reduced from abou=
t
> > 3.5s to 2s.
> >=20
> > please review this patch. Any comments are welcome. :)
>=20
> Well, given that our single-thread resume is not exactly correct,
you mean that the current serial resume mechanism still doesn't work
stable, right?

>  I think
> it's _way_ to early to indroduce things like this.
Right, it's not for upstream.
But it looks good in theory, and it does works without any side effect
in my case.
So the patch was sent out here to see if there are some problems that
are not covered by this patch, like the one Alan pointed out. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
