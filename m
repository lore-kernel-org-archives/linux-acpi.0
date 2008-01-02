From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 2 Jan 2008 23:01:45 +0100
Message-ID: <200801022301.45706.rjw@sisk.pl>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com> <200801021505.39789.rjw@sisk.pl> <477C019D.1070001@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43776 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbYABV7x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jan 2008 16:59:53 -0500
In-Reply-To: <477C019D.1070001@nigel.suspend2.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nigel@nigel.suspend2.net
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>

On Wednesday, 2 of January 2008, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > On Wednesday, 2 of January 2008, Shaohua Li wrote:
> >> ACPI defines a hardware signature. BIOS calculates the signature
> >> according to hardware configure, if hardware changes, the signature will
> >> change, in this case, S4 resume should fail.
> > 
> > The idea is fine, but I'd prefer to do that in a more straightforward way.
> > Namely, we can just:
> > * write the signature into a variable in, for example,
> >   acpi_hibernation_prepare() (then, the "old" signature value will be
> >   automatically saved in the image)
> > * compare it with a the "new" value read from the BIOS in
> >   acpi_hibernation_leave() and panic if there's a mismatch
> > * add a configuration option to disable this behavior (just in case)
> > This way we can avoid modifying the entire generic interface to add the feature
> > specific to ACPI.
> > 
> > Still, if you want the boot kernel to check the signature, which will be more
> > elegant (but please note that on x86-64 the boot kernel need not support ACPI
> > at all), you can use the (recently introduced) architecture part of the image
> > header for this purpose, without modifying the generic interface.
> 
> I suppose we can always disable this when we start to support hardware
> changing over hibernate (I have ideas in this direction - memory cold
> plugging, for a start).

Well, if we support such features, we won't be following ACPI any more.

Greetings,
Rafael
