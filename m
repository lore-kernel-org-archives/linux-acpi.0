From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 13:20:54 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EFF086@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:15052 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751315AbWBCSVd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 13:21:33 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>, linux-acpi@vger.kernel.org

RE: RSDT

Actually it is the FADT -- Fixed ACPI Description Table -
which describes up to C3.  The optional _CST in the DSDT
can over-ride that, and provide any number of C-states,
including states that come and go at run-time.
The FADT also has a bit, P_LVL2_UP, which says that
not matter if the latencies in the FADT are legal or not,
C2 (and up) work only when booted in a UP configuration.

Re: 8 cstates
We (Linux) simply picked the number 8 to size an array bigger than the
max number of C-states we'd seen in practice.  A linked
list looked overly complicated.  I've not seen more
than C4 on systems today.

cheers,
-Len

