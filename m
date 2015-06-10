From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 3.10.80 vs. 3.10.79
Date: Thu, 11 Jun 2015 01:23:32 +0200
Message-ID: <25627634.TOSvDFmF1a@vostro.rjw.lan>
References: <CAL1RGDV6hr3_Oa6O-kPzx9EemtOWWtYq+-RkCzN7axNPLz5MJw@mail.gmail.com> <CAL1RGDWBd9Y_KLoT+DZX0Js+y9C8c4mTj9b3n+-8C=_vE0=pPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55385 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752250AbbFJW5m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2015 18:57:42 -0400
In-Reply-To: <CAL1RGDWBd9Y_KLoT+DZX0Js+y9C8c4mTj9b3n+-8C=_vE0=pPw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, George McCollister <george.mccollister@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Tuesday, June 09, 2015 04:51:35 PM Roland Dreier wrote:
> On Tue, Jun 9, 2015 at 4:43 PM, Roland Dreier <roland@purestorage.com> wrote:
> > I understand that the change here fixed another regression, but I'm
> > wondering if there's a way to make everyone happy here?  I can provide
> > debugging info from my system as required...
> 
> Maybe sent my mail too quickly, as I have some thoughts after looking
> at the code.
> 
> From the link order, drivers/acpi init wll be called before
> drivers/pnp init, right?  In my case, the acpi resources ("ACPI
> PM1a_EVT_BLK") etc are under a pnp bus.  But if acpi requests the
> resources first, then pnp can't request the enclosing range.
> 
> Is the right fix to make sure the pnp init happens before acpi
> requests resources?

I need to have a deeper look at things.

Can you please file a bug at bugzilla.kernel.org to track this and attach
the output of acpidump from the affected system in there?

Rafael

