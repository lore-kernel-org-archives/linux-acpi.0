From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Date: Fri, 1 Sep 2006 05:12:21 +0100
Message-ID: <20060901041221.GA15330@srcf.ucam.org>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain> <200608312353.05337.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:2986 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932070AbWIAEMf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Sep 2006 00:12:35 -0400
Content-Disposition: inline
In-Reply-To: <200608312353.05337.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: jg@laptop.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org

On Thu, Aug 31, 2006 at 11:53:04PM -0400, Len Brown wrote:

> The Geode doesn't suport any C-states -- so ACPI wouldn't help them there anyway.

Are you sure of that? The docs I have here suggest C1 and C2, but it's 
possible that that's just the companion chip and they aren't implemented 
in the CPU.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
