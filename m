From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Fri, 17 Oct 2008 10:09:00 +0800
Message-ID: <1224209340.2735.276.camel@rzhang-dt>
References: <1223885404.2735.183.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D83085803194DE3@orsmsx503.amr.corp.intel.com>
	 <1223947180.2735.228.camel@rzhang-dt>
	 <alpine.LFD.1.10.0810151801290.3026@localhost.localdomain>
	 <4911F71203A09E4D9981D27F9D83085803278477@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:60432 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbYJQCLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Oct 2008 22:11:22 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085803278477@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2008-10-16 at 09:51 -0600, Moore, Robert wrote:
> 
> >-----Original Message-----
> >From: Len Brown [mailto:lenb@kernel.org]
> >Sent: Wednesday, October 15, 2008 3:21 PM
> >To: Zhang, Rui
> >Cc: Moore, Robert; linux-acpi
> >Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
> >
> >
> >Bob,
> >note that we already changed acpidump to get the inactive static
> >tables.  We did this back when we were running into bugs with "invalid"
> >XSDT's and found some machines needed to revert back to using the RSDTs.
> >
> >Indeed, while I think we nailed some of the major offenders,
> >But I suspect we still have some bug compatibility detective work
> >to do in that area.
> >
> 
> I wasn't aware that acpidump can now get the tables from the RSDT also. This is good.
> 
> As I mentioned, I would like to eventually pull acpidump into the core ACPICA code and make it OS-independent at the same time.
> 
> 
> >So what Rui is doing here in exposing inactive tables it to get
> >/sys/firmware/acpi/tables to have the equal capability
> >of the existing acpidump kvm reader.
> >
> 
> I was pointing out that there is significant overhead in acquiring these unused tables.
well, it's true.

>  I'm not sure I understand exactly why this is desired, since acpidump already does this.
> 
there must be some communication problems. :)
As I understand, we are going to get rid of acpidump.
so that we need to make Linux/ACPI dump all the acpi tables instead of
acpidump.
If this is true, I'm afraid we still need this patch although I don't
like it neither. :(

Len, can you verify this?

thanks,
rui
> 

