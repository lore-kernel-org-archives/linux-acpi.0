From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] Introduce GPE refcounting (was: Re: Recent GPE patches - some questions.)
Date: Wed, 10 Feb 2010 22:36:34 +0100
Message-ID: <201002102236.34881.rjw@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com> <201002070317.47029.rjw@sisk.pl> <1265837393.8599.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43931 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab0BJVgB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Feb 2010 16:36:01 -0500
In-Reply-To: <1265837393.8599.2.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Wednesday 10 February 2010, Maxim Levitsky wrote:
> On Sun, 2010-02-07 at 03:17 +0100, Rafael J. Wysocki wrote: 
> > On Sunday 07 February 2010, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > On Wednesday 03 February 2010, Moore, Robert wrote:
> > > > Matthew, 
> > > > 
> > > > Thanks for your response to my questions.
> > > > 
> > > > I've been thinking about these interfaces:
> > > > 
> > > > acpi_ref_runtime_gpe
> > > > acpi_ref_wakeup_gpe
> > > > acpi_unref_runtime_gpe
> > > > acpi_unref_wakeup_gpe
> > > > 
> 
> One minor, mostly off-topic question.
> Currently to enable static wakeup one has to write /proc/acpi/wakeup.

That depends on the device.  For PCI devices there's another interface for
that, which is /sys/devices/.../power/wakeup .

> Do you consider propagating device wakeup settings to acpi,
> so /proc/acpi/wakeup could finally be deprecated?

We already do that for PCI devices.

In fact, I'd only recommend using /proc/acpi/wakeup for reading the list of
wakeup devices visible to ACPI.

Rafael
