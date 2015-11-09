From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/2] acpi: nfit: Add support for hot-add
Date: Mon, 09 Nov 2015 22:25:17 +0100
Message-ID: <3407281.JKJqFNJUkI@vostro.rjw.lan>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com> <CAPcyv4jK+smY6gVaxPAsWh7iZTo5+ZzrGy9SWqmdM1A4sp+jeA@mail.gmail.com> <CAPcyv4h-OqKcY50Nfb5XQyfxCPQqWs+j4hgkG20bJiUr1ue26g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56060 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752357AbbKIUz7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 15:55:59 -0500
In-Reply-To: <CAPcyv4h-OqKcY50Nfb5XQyfxCPQqWs+j4hgkG20bJiUr1ue26g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

On Monday, November 09, 2015 10:25:10 AM Dan Williams wrote:
> On Sun, Nov 8, 2015 at 5:26 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Sun, Nov 8, 2015 at 4:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Saturday, November 07, 2015 10:57:17 AM Dan Williams wrote:
> >>> Rafael, awaiting your ack...
> >>
> >> Well, this seems to be entirely NFIT-related.
> >>
> >> Is there anything in particular you want me to look at?
> >>
> >
> > This might be more relevant for a follow-on patch, but I wonder if the
> > core should be guaranteeing that the ->notify() callback occurs under
> > device_lock().  In the case of NFIT it seems possible for the notify
> > event to race ->add() or ->remove(), but maybe I missed some other
> > guarantee?
> 
> ...and no worries if you don't see anything worth commenting on, the
> bulk of this is indeed NFIT specific.

I actually don't see anything objectionable in it, although admittedly I've
just had a cursorly look at it.

Thanks,
Rafael

