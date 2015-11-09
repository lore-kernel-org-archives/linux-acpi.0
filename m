From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Mon, 09 Nov 2015 22:28:37 +0100
Message-ID: <1598802.EEC0oEGDtq@vostro.rjw.lan>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com> <CAPcyv4jK+smY6gVaxPAsWh7iZTo5+ZzrGy9SWqmdM1A4sp+jeA@mail.gmail.com> <1694961.7tam4vTeyJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41233 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750819AbbKIU7T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 15:59:19 -0500
In-Reply-To: <1694961.7tam4vTeyJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

On Monday, November 09, 2015 10:24:00 PM Rafael J. Wysocki wrote:
> On Sunday, November 08, 2015 05:26:03 PM Dan Williams wrote:
> > On Sun, Nov 8, 2015 at 4:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Saturday, November 07, 2015 10:57:17 AM Dan Williams wrote:
> > >> Rafael, awaiting your ack...
> > >
> > > Well, this seems to be entirely NFIT-related.
> > >
> > > Is there anything in particular you want me to look at?
> > >
> > 
> > This might be more relevant for a follow-on patch, but I wonder if the
> > core should be guaranteeing that the ->notify() callback occurs under
> > device_lock().  In the case of NFIT it seems possible for the notify
> > event to race ->add() or ->remove(), but maybe I missed some other
> > guarantee?
> 
> No, you didn't.
> 
> I'd rather drop the ->notify callback completely, because it's kind of
> confusing, as there are other (non-ACPI) drivers that need to receive
> ACPI notifications too and they have to use the raw ACPICA's
> acpi_install_notify_handler() interface.  Having a special interface for
> that for ACPI drivers only doesn't make much sense to me.
> 
> That said, the ACPICA's notify handling code is inherently racy with respect to
> module unload, so potentially dangerous in any modular code.
> 
> IMO, a generic module-safe wrapper around that code is needed, but since I
> haven't had the time to introduce one for quite a while, I guess it would be
> fine to add device locking around ->notify in acpi_bus_notify(), at least for
> the time being.

And in acpi_device_notify() for that matter.

Thanks,
Rafael

