From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to ACPI_ERROR/WARNING
Date: Fri, 3 Feb 2006 13:41:00 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E043CB638@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:57005 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1945994AbWBCVlJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 16:41:09 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, ACPI-ML <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

BTW,

The implementations of ACPI_ERROR/WARNING/INFO automatically insert a
newline at the end of the message, along with the ACPI version.

+		ACPI_ERROR((AE_INFO, "Error reading AC Adapter
state\n"));

So, you will probably want to remove the \n at the end of each of these.

With hundreds of such messages, this actually saves an "interesting"
amount of memory.

Also, I created the ACPI_EXCEPTION interface that will decode and
display the ACPI_STATUS code; you may want to use this instead of
ACPI_ERROR is some cases.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Thomas Renninger
> Sent: Friday, February 03, 2006 1:20 PM
> To: ACPI-ML; Brown, Len
> Subject: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to
ACPI_ERROR/WARNING
> 
> This patch lets all ACPI errors and warnings be printed
> even ACPI_DEBUG is disabled.
> 
> I removed all "proc entry could not be created" messages
> and returned -ENODEV.
> 
> I also removed all "Error removing/adding notify handler" messages.
> I will provide a second patch (ACPICA) and add a message to
> the add/remove_handler function itself.
> 
> This should give the "non kernel debuggers" a chance to figure out
> why their xy hardware does not work without the need of recompiling
> kernels. And should provide as with better bug reports...
> 
> This one is on top of Len's latest 2.6.16-rc1/2 push.
> 
>     Thomas

