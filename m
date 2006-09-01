From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: ACPI: Idle Processor PM Improvements
Date: Fri, 1 Sep 2006 09:51:17 -0600
Message-ID: <20060901155117.GD18448@cosmic.amd.com>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
 <200608311713.21618.bjorn.helgaas@hp.com>
 <1157070616.7974.232.camel@localhost.localdomain>
 <200608312353.05337.len.brown@intel.com>
 <20060901041221.GA15330@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:49887 "EHLO
	outbound1-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932097AbWIAPvO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Sep 2006 11:51:14 -0400
In-Reply-To: <20060901041221.GA15330@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

On 01/09/06 05:12 +0100, Matthew Garrett wrote:
> On Thu, Aug 31, 2006 at 11:53:04PM -0400, Len Brown wrote:
> 
> > The Geode doesn't suport any C-states -- so ACPI wouldn't help them there anyway.
> 
> Are you sure of that? The docs I have here suggest C1 and C2, but it's 
> possible that that's just the companion chip and they aren't implemented 
> in the CPU.

C1 is essentially suspend on hlt.  We have something called Automatic Hardware
Clock Gating that kicks in when the blocks go unused, so that saves a bit
more power (especially in the south bridge) then we would with just a simple
hlt.  In any event, this already happens without the assistance of ACPI.

The 5536 has support for a C2 state as well, but I don't know if that
has any effect on the GX or not.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


