From: Bela Lubkin <blubkin@vmware.com>
Subject: RE: [Openipmi-developer] [PATCH 2/4] ipmi: Remove SPMI table based
 device discovery method
Date: Fri, 5 Mar 2010 04:58:12 -0800
Message-ID: <E0AA796A7E3F4C4E8F1065D15FE478610176ABB8AD@EXCH-MBX-4.vmware.com>
References: <20100304033146.30205.68689.stgit@bob.kio>
	 <20100304034415.30205.59685.stgit@bob.kio>
	 <E0AA796A7E3F4C4E8F1065D15FE478610176ABB89F@EXCH-MBX-4.vmware.com>
 <1267728420.2437.162.camel@zim>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:49154 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771Ab0CEM6N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Mar 2010 07:58:13 -0500
In-Reply-To: <1267728420.2437.162.camel@zim>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Myron Stowe' <myron.stowe@hp.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

Myron Stowe wrote:

> ACPI in new systems does tend to present a lot of challenges. 
>  My job is
> new platform enablement focused which more often than not 
> translates to
> "helping discover and fix BIOS/ACPI issues" so I definitely 
> understand.
> 
> You also astutely point out that ACPI's static tables are 
> available for
> use by an OS - or OSPM in ACPI speak - much earlier than its 
> namespace.
> This is true but it is also our belief that no one uses it except HP.

Are you watching what goes on in embedded systems or only
the PC / server marketplace?

> I see how one's life could be easier relying on the BIOS setting up
> static tables such as either the SMBIOS or SPMI.  That way the BIOS is
> taking the dynamic aspects into account relieving the OS, or 
> OS/platform
> bring up engineer, from such.  In such a case, what benefits does the
> SPMI table provide as opposed to the SMBIOS table?

It gives you twice as many chances to find a sufficiently
non-buggy table to get on with your work ;-}

> > I would be more comfortable if you kept this code, perhaps
> > suppressed under a "CONFIG_IPMI_SPMI" config option.
> 
> I just don't see enough remaining value in keeping the SPMI table
> capability.  It seems to be redundant, and if truly so, just adds
> unnecessary code, complexity, and maintenance aspects to the 
> driver.  We
> typically don't keep code in the kernel just for bring up efforts.

Well, I'm not doing any such bring-up work so I will
step out of the discussion here.  But I'll leave you
with a bit of a curse: if you remove this code, I
predict that the person it will come back to bite is
you...

>Bela<