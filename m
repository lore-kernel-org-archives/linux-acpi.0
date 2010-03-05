From: Myron Stowe <myron.stowe@hp.com>
Subject: RE: [Openipmi-developer] [PATCH 2/4] ipmi: Remove SPMI table based
 device discovery method
Date: Fri, 05 Mar 2010 10:13:50 -0700
Message-ID: <1267809230.2411.114.camel@zim>
References: <20100304033146.30205.68689.stgit@bob.kio>
	 <20100304034415.30205.59685.stgit@bob.kio>
	 <E0AA796A7E3F4C4E8F1065D15FE478610176ABB89F@EXCH-MBX-4.vmware.com>
	 <1267728420.2437.162.camel@zim>
	 <E0AA796A7E3F4C4E8F1065D15FE478610176ABB8AD@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:11841 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab0CERNw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2010 12:13:52 -0500
In-Reply-To: <E0AA796A7E3F4C4E8F1065D15FE478610176ABB8AD@EXCH-MBX-4.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bela Lubkin <blubkin@vmware.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

On Fri, 2010-03-05 at 04:58 -0800, Bela Lubkin wrote:
> Myron Stowe wrote:
> 
> > ACPI in new systems does tend to present a lot of challenges. 
> >  My job is
> > new platform enablement focused which more often than not 
> > translates to
> > "helping discover and fix BIOS/ACPI issues" so I definitely 
> > understand.
> > 
> > You also astutely point out that ACPI's static tables are 
> > available for
> > use by an OS - or OSPM in ACPI speak - much earlier than its 
> > namespace.
> > This is true but it is also our belief that no one uses it except HP.
> 
> Are you watching what goes on in embedded systems or only
> the PC / server marketplace?

No, I do not watch the embedded system space.  Would such folks tend to
track openipmi-developer@lists.sourceforge.net (at least with respect to
IPMI)?  If not, are you aware of a specific mail reflector that I should
be including in this discussion?

> 
> > I see how one's life could be easier relying on the BIOS setting up
> > static tables such as either the SMBIOS or SPMI.  That way the BIOS is
> > taking the dynamic aspects into account relieving the OS, or 
> > OS/platform
> > bring up engineer, from such.  In such a case, what benefits does the
> > SPMI table provide as opposed to the SMBIOS table?
> 
> It gives you twice as many chances to find a sufficiently
> non-buggy table to get on with your work ;-}
> 
> > > I would be more comfortable if you kept this code, perhaps
> > > suppressed under a "CONFIG_IPMI_SPMI" config option.
> > 
> > I just don't see enough remaining value in keeping the SPMI table
> > capability.  It seems to be redundant, and if truly so, just adds
> > unnecessary code, complexity, and maintenance aspects to the 
> > driver.  We
> > typically don't keep code in the kernel just for bring up efforts.
> 
> Well, I'm not doing any such bring-up work so I will
> step out of the discussion here.  But I'll leave you
> with a bit of a curse: if you remove this code, I
> predict that the person it will come back to bite is
> you...

I hope I'm not coming off as closed minded and causing you to disengage
as most every concern you have raised has been valid and needful of
consideration.  As mean as putting a jinx on me was (I'm mostly kidding
there), you are correct there too: it will be me that it comes back to
bite.  I still feel that this is worth pursuing as no progress is ever
made without some risk but I do want discussions to occur so that I can
learn, preferably beforehand, if I am wrong.

Myron
> 
> >Bela<


-- 
Myron Stowe                             HP Open Source Linux Lab (OSLL)

