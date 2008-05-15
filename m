From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware
	doesn't define one
Date: Thu, 15 May 2008 10:15:39 +0800
Message-ID: <1210817739.2929.24.camel@rzhang-crestline.sh.intel.com>
References: <20080514010000.GB21608@srcf.ucam.org>
	 <20080514010300.GC21608@srcf.ucam.org>
	 <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org>
	 <20080514093304.GB28678@srcf.ucam.org>
	 <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com>
	 <20080515010426.GA13927@srcf.ucam.org>
	 <1210814699.2929.10.camel@rzhang-crestline.sh.intel.com>
	 <20080515015831.GA14829@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63970 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbYEOCPe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 22:15:34 -0400
In-Reply-To: <20080515015831.GA14829@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>


On Thu, 2008-05-15 at 02:58 +0100, Matthew Garrett wrote:
> On Thu, May 15, 2008 at 09:24:59AM +0800, Zhang Rui wrote:
> > On Thu, 2008-05-15 at 09:04 +0800, Matthew Garrett wrote:
> > >  I'll implement that tomorrow.
> > sorry I don't understand this. what will you implement?
> 
> I'll modify my patch so it uses the devices in a _TZD package if they're 
> present.
> 
Hmm, ACPI thermal zone doesn't know how to throttle the devices in a
_TZD package, so I don't think we can use the _TZD devices.

thanks,
rui

