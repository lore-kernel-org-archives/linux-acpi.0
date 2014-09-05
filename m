From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI: Invalid active2 threshold
Date: Fri, 05 Sep 2014 14:02:28 +0800
Message-ID: <1409896948.8085.156.camel@rzhang1-toshiba>
References: <201409041840.04182.a.miskiewicz@gmail.com>
	 <2013965.03uY2hDTmQ@vostro.rjw.lan>
	 <1409880891.8085.147.camel@rzhang1-toshiba>
	 <201409050703.56802.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41940 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbaIEGCj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Sep 2014 02:02:39 -0400
In-Reply-To: <201409050703.56802.a.miskiewicz@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Fri, 2014-09-05 at 07:03 +0200, Arkadiusz Miskiewicz wrote:
> On Friday 05 of September 2014, Zhang Rui wrote:
> > On Thu, 2014-09-04 at 21:21 +0200, Rafael J. Wysocki wrote:
> > > On Thursday, September 04, 2014 06:40:04 PM Arkadiusz Miskiewicz wrote:
> > > > Hi.
> > > > 
> > > > I'm using 3.17.0-rc3-00002-g7505cea kernel on Dell XPS 15 machine:
> > > > DMI: Dell Inc. XPS 15 9530/XPS 15 9530, BIOS A06 07/16/2014
> > > > (this is latest bios)
> > > > 
> > > > After loading thermal acpi driver I get:
> > > > 
> > > > [54136.633643] ACPI: Invalid active2 threshold
> > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
this is a BIOS bug. _AC2 is defined while _AL2 is not, thus this is an
invalid active trip point.
But it won't hurt IMO, because there are two ACPI Fan devices, and they
are both used (for active trip point 0 and 1) in the ACPI thermal
management in your laptop.

> > > > [54136.633761] thermal LNXTHERM:00: registered as thermal_zone6
> > > > [54136.633763] ACPI: Thermal Zone [TZ00] (28 C)
> > > > [54136.634009] thermal LNXTHERM:01: registered as thermal_zone7
> > > > [54136.634011] ACPI: Thermal Zone [TZ01] (-266 C)
> > > > 
This is more serious to me. 
can you please file a bug at
https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach your acpidump output there.

thanks,
rui

> > > > 
> > > > I assume bios is buggy (right?)
> > > 
> > > Well, we don't seem to like the value for some reason.  Also the -266 C
> > > for TZ01 looks suspicious.
> > > 
> > > > What problems can happen to this machine due to this problem? It is
> > > > quite hot frequently, so I wonder if there is some thermal management
> > > > problem with it.
> > > 
> > > I'm leaving this question to Rui.
> > 
> > It looks like ACPI thermal driver fails to parse _AC2 control methods.
> > please attach the acpidump output.



