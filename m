From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Date: Wed, 21 Jun 2006 15:17:02 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A47CBF37@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6430 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030484AbWFVBlB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2006 21:41:01 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Loop may be correctly waiting for the owner/pending bit to be set, just
checking, I don't remember all the bit values.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Wednesday, June 21, 2006 2:09 PM
> To: Andreas Mohr; Andrew Morton
> Cc: Brown, Len; linux-acpi@vger.kernel.org;
linux-kernel@vger.kernel.org
> Subject: RE: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
> 
> I may be interpreting this incorrectly, but are you busy-waiting on
the
> ACPI Global Lock to become free?
> 
> Bob
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Andreas Mohr
> > Sent: Wednesday, June 21, 2006 2:01 PM
> > To: Andrew Morton
> > Cc: Brown, Len; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> > Subject: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
> >
> >
> > Use cpu_relax() in __acpi_acquire_global_lock() etc.
> >
> >
