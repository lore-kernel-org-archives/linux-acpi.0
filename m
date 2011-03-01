From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] pnpacpi: Better format error message
Date: Tue, 1 Mar 2011 14:25:44 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858CA9C14A4@orsmsx503.amr.corp.intel.com>
References: <201103011513.40235.trenn@suse.de>
 <201103011743.33975.trenn@suse.de>
 <4911F71203A09E4D9981D27F9D830858CA9C0F46@orsmsx503.amr.corp.intel.com>
 <201103012208.14190.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25824 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522Ab1CAWZp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2011 17:25:45 -0500
In-Reply-To: <201103012208.14190.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bjorn@helgaas.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Tuesday, March 01, 2011 1:08 PM
> To: Moore, Robert
> Cc: Bjorn Helgaas; lenb@kernel.org; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH] pnpacpi: Better format error message
> 
> On Tuesday 01 March 2011 18:03:23 Moore, Robert wrote:
> > - there seem to be another problem in the acpica resource handling
> > depths if _CRS functions do not return anything.
> >
> >
> > Strictly speaking it's illegal for _CRS to not return anything.
> > Practically, perhaps we should repair this case to a "NULL" resource
> > descriptor which perhaps could be defined as a resource descriptor
> > with a single End Tag descriptor.
> Be aware that this was an early BIOS.
> I am fine if there is an error message if this is not allowed.
> It's the first time I saw such a message and an empty resource func.
> 
>     Thomas

The goal of the repair code is of course to simplify the drivers. What we'd like to be able to do is guarantee that if an AE_OK is returned by the evaluation of a predefined ACPI name, the returned object is of the correct type. It seems to me that a "resource descriptor" is a special type of buffer, so we can add support for that in the repair code. 

In the _CRS case above, we could return a resource descriptor with simply an EndTag -- the driver can of course squawk about this if it desires.

On the other hand, we could just punt on the conversion and just return an OBJECT_TYPE error.


