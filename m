From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared GPEs
Date: Thu, 25 Feb 2010 20:56:24 +0100
Message-ID: <201002252056.24227.rjw@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com> <201002200014.04936.rjw@sisk.pl> <4B8693C0.4020701@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48008 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933028Ab0BYTzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2010 14:55:42 -0500
In-Reply-To: <4B8693C0.4020701@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Brown, Len" <len.brown@intel.com>

On Thursday 25 February 2010, Alexey Starikovskiy wrote:
> Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > --- linux-2.6.orig/drivers/acpi/ec.c
> > +++ linux-2.6/drivers/acpi/ec.c
> > @@ -307,7 +307,11 @@ static int acpi_ec_transaction(struct ac
> >  	pr_debug(PREFIX "transaction start\n");
> >  	/* disable GPE during transaction if storm is detected */
> >  	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> > -		acpi_disable_gpe(NULL, ec->gpe);
> > +		/*
> > +		 * It has to be disabled at the hardware level regardless of the
> > +		 * GPE reference counting, so that it doesn't trigger.
> > +		 */
> > +		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
> >  	}
> >  =20
> EC should have non-shared GPE, according to spec. Thus, refcounting i=
s
> not needed here anyway.

So we can just use acpi_disable_gpe() here and analogously with enable
and in suspend/resume?

OK, I'll send a followup patch for that.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
