From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: DSDT database
Date: Fri, 8 Sep 2006 09:41:24 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4E74F4A@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27059 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1750848AbWIHQmB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Sep 2006 12:42:01 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Thomas W. Carley" <tcarley@embedded-zone.com>
Cc: linux-acpi@vger.kernel.org, "Yu, Ling L" <ling.l.yu@intel.com>

I find the DSDTs to be useful for examining the code that is written by
the various BIOS vendors, to find typical practices, unusual practices,
etc. Useful in the development of the AML interpreter and ASL compiler.

For this reason, the more DSDTs available, the better.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Len Brown
> Sent: Friday, September 08, 2006 9:39 AM
> To: Thomas W. Carley
> Cc: linux-acpi@vger.kernel.org; Yu, Ling L
> Subject: Re: DSDT database
> 
> On Friday 08 September 2006 12:04, Thomas W. Carley wrote:
> > ACPI list,
> >
> > I am looking into the level of SMBus support in ACPI
implementations. I
> > see that the sourceforge project has 652 DSDT's in its database. I
would
> > like to run some automated scripts over these to get some statistics
> > about the level of SMBus support. However, downloading them one at a
> > time will take forever. Is the DSDT database available in whole? Can
> > someone send me a link, or send the files directly?
> 
> Maybe Yu Ling knows how to get "behind the mirrors" of the web server
> and can run something for you there?
> 
> Another possibility is that you supply the script you want to run
> and folks on the list can mail you the output.  While I've never
> submitted a DSDT to the web site because I fundamentally do not
> believe it modifying DSDTs as a solution for Linux problems,
> I do have a couple DSDTs on hand.
> 
> BTW. exactly what is it that you are trying to learn?
> 
> cheers,
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
