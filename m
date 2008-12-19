From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 0/3] pm: device parallel resume mechanism
Date: Fri, 19 Dec 2008 18:15:10 +0100
Message-ID: <200812191815.11153.rjw@sisk.pl>
References: <1229668448.562.88.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46043 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbYLSRPb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 12:15:31 -0500
In-Reply-To: <1229668448.562.88.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>

On Friday, 19 of December 2008, Zhang Rui wrote:
> Hi, all,
>=20
> =EF=BB=BFThe resume process can be split into 3 parts, BIOS resume ti=
me, kernel
> resume time and X/application resume time.
> And device resume takes most of the kernel resume time.
> this patch set introduces a new mechanism to resume device in paralle=
l
> which can reduce the device resume time a lot.
>=20
> In this proposal, some devices can create its own workqueue for
> parallel resume. And for all the other devices that depends on this
> device, their resume methods are queued in the same workqueue.
> And we flush all the workqueues before resuming X/applications.
>=20
> As the devices vary from different platforms. it's hard to give an ex=
act
> number of how much time it can reduce.
> Here are some of my test results:
> 1. eeepc901, kernel resume time can be reduced from about 2.1 seconds=
 to
> 1.6 seconds.
> 2. a SantaRosa testbox, kernel resume time can be reduced from about
> 3.5s to 2s.
>=20
> please review this patch. Any comments are welcome. :)

Well, given that our single-thread resume is not exactly correct, I thi=
nk
it's _way_ to early to indroduce things like this.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
