From: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] acpi, nfit: fix the memory error check in nfit_handle_mce
Date: Fri, 21 Apr 2017 14:35:51 -0600
Message-ID: <20170421203551.GC10645@omniknight.lm.intel.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
 <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
 <1492804517.2738.25.camel@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F6127653B@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161756AbdDUUhM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 16:37:12 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F6127653B@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 04/21, Luck, Tony wrote:
> >> > +       if (!(mce->status & 0xef80) == BIT(7))
> >> 
> >> Can we get a define for this, or a comment explaining all the magic
> >> that's happening on that one line?
> >
> > Yes - also like lkp pointed out, the check isn't correct at all. Let me
> > figure out what really needs to be done, and I will resend with a better
> > comment. 
> 
> Needs extra parentheses to make it right. Vishal, sorry I led you astray.
> 
> 	if (!((mce->status & 0xef80) == BIT(7)))

Is this still right though? Anything AND'ed with 0xef80 will never equal
BIT(7) which is simply 01000000 binary (the lowest byte of the left hand
side is '0')

> 
> The magic is shown in table 15-9 of the Intel Software Developers Manual
> (but perhaps not well explained there).
> 
> mce->status in the above code is a value plucked from a machine check
> bank status register. See figure 15-6 in the SDM.  The important bits for this
> are {15:0} which are the "MCA Error code".  Table 15-9 shows how these
> are grouped into types, where the type is defined by the most significant '1'
> bit in the field (excluding bit 12 which is the Correction Report Filtering bit,
> see section 15.9.2.1).
> 
> So if BIT(3) is the most significant bit, the this is a "Generic Cache Hierarchy"
> error, BIT(4) denotes a TLB error, BIT(7) a Memory error, and so on.
> 
> Maybe we should have defines in mce.h for them?  It gets a bit more complicated
> as all the above only applies to Intel branded X86 CPUs ... on AMD different
> decoding rules apply.
> 
> -Tony
> 
> 


