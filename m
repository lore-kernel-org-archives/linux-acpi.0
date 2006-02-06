From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to ACPI_ERROR/WARNING
Date: Mon, 6 Feb 2006 14:50:35 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0440B436@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:3805 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964850AbWBFWul convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 17:50:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

> Also added the EXPORT_SYMBOLS(ut_warning/error/exception) function
decl.
> in
> (in a separated patch -> ACPICA, acpi/utilities/utmisc.c).

Don't these belong somewhere else?

> Also added errors inside remove/install handler funcs (in a separated
> patch -> ACPICA,
> acpi/events/evxface.c).

So, you are saying that there are insufficient error messages in
evxface.c, I'll look at it.



> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Monday, February 06, 2006 12:57 PM
> To: Moore, Robert
> Cc: ACPI-ML; Brown, Len
> Subject: Re: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to
> ACPI_ERROR/WARNING
> 
> Moore, Robert wrote:
> > BTW,
> >
> > The implementations of ACPI_ERROR/WARNING/INFO automatically insert
a
> > newline at the end of the message, along with the ACPI version.
> >
> > +		ACPI_ERROR((AE_INFO, "Error reading AC Adapter
> > state\n"));
> >
> > So, you will probably want to remove the \n at the end of each of
these.
> >
> > With hundreds of such messages, this actually saves an "interesting"
> > amount of memory.
> >
> > Also, I created the ACPI_EXCEPTION interface that will decode and
> > display the ACPI_STATUS code; you may want to use this instead of
> > ACPI_ERROR is some cases.
> >
> Ok, I now made use of the ACPI_EXCEPTION, whenever possible.
> 
> Also shortend some "Error:", "ACPI bug:" messages.
> 
> Also added the EXPORT_SYMBOLS(ut_warning/error/exception) function
decl.
> in
> (in a separated patch -> ACPICA, acpi/utilities/utmisc.c).
> 
> Also added errors inside remove/install handler funcs (in a separated
> patch -> ACPICA,
> acpi/events/evxface.c).
> 
>      Thomas
