From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Thu, 27 Aug 2015 19:26:30 +0200
Message-ID: <53385977.18c1CJRJ2u@vostro.rjw.lan>
References: <20150821121152.GA26813@intel-desktop> <20150827161321.GA9886@intel-desktop> <20150827083050.GC28428@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50948 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751574AbbH0Q65 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2015 12:58:57 -0400
In-Reply-To: <20150827083050.GC28428@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>, linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Thursday, August 27, 2015 11:30:50 AM Mika Westerberg wrote:
> On Thu, Aug 27, 2015 at 09:43:21PM +0530, Kasagar, Srinidhi wrote:
> > >From 970c704dbb05aa8392b6e1090ceaf9ed76b6436b Mon Sep 17 00:00:00 2001
> > From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> > Date: Thu, 27 Aug 2015 21:30:55 +0530
> > Subject: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell
> > 
> > LPSS devices in Braswell does not need the default 10ms
> > d3_delay imposed by PCI specification. Removing this
> > unnecessary delay significantly reduces the resume time
> > approximately upto 200ms on this platform.
> > 
> > Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> 
> Looks good now, thanks!
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

Rafael

