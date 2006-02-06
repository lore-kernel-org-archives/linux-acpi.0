From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to ACPI_ERROR/WARNING
Date: Mon, 6 Feb 2006 15:06:24 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0440B4A2@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:44207 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964857AbWBFXGk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 18:06:40 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

I meant, EXPORT_SYMBOLS is Linux-specific and belongs in a
linux-specific header (wherever the rest of the ACPICA public symbols
are exported)



> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Monday, February 06, 2006 3:01 PM
> To: Moore, Robert
> Cc: ACPI-ML; Brown, Len
> Subject: Re: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to
> ACPI_ERROR/WARNING
> 
> Moore, Robert wrote:
> >> Also added the EXPORT_SYMBOLS(ut_warning/error/exception) function
> > decl.
> >> in
> >> (in a separated patch -> ACPICA, acpi/utilities/utmisc.c).
> >
> > Don't these belong somewhere else?
> I thought everything in subdirs is ACPICA...
> 
> >
> >> Also added errors inside remove/install handler funcs (in a
separated
> >> patch -> ACPICA,
> >> acpi/events/evxface.c).
> >
> > So, you are saying that there are insufficient error messages in
> > evxface.c, I'll look at it.
> >
> 
> Grep in the big one for acpi_remove_notify_handler or
> "Error installing notify handler" ...
