From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Mon, 7 Jul 2008 14:34:09 +0200
Message-ID: <200807071434.10754.rjw@sisk.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <ac8af0be0807062054nbced6b0pd378aeda91a3c538@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60496 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYGGMc1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 08:32:27 -0400
In-Reply-To: <ac8af0be0807062054nbced6b0pd378aeda91a3c538@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, 7 of July 2008, Zhao Forrest wrote:
> > Hello,
> >
> >  Matthew, you have not added your sign-off with the original patch, please
> > do so now.
> >
> >  Rafael, please try this change together with
> > patch-2.6.26-rc1-20080505-mpparse-acpi-noirq0-2 and see if this fixes your
> > system.
> >
> >  I have tried the patches with a wildcard entry added to acpi_dmi_table[]
> > so that it trips for my system.  The result is as follows:
> 
> Since we add a new entry to acpi_dmi_table[], I think it's necessary
> for this new entry to preserve the semantics of this table, that is
> "acpi=force overrules DMI blacklist", am I right?

Can you please elaborate?

What exactly are we supposed to do apart from adding the new entries to the
table?

Thanks,
Rafael
