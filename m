From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI & driver patches for Linux-2.6.32-rc0
Date: Sun, 27 Sep 2009 03:50:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909270348570.16783@localhost.localdomain>
References: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain>
 <4ABCB2CA.4020709@mandriva.org>
 <d3f22a0909261902o5e48c2a0lab56fca21edf8c5b@mail.gmail.com>
 <1254016503.17697.21.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:34256 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbZI0Hut (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2009 03:50:49 -0400
In-reply-to: <1254016503.17697.21.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Thomas Backlund <tmb@mandriva.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>


> > This gets my laptop flooding logs with:

> > 
> > > ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20090903/evregion-424)
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.GBST] (Node ffff88013f81c5e0), AE_TIME
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_.BAT0._BST] (Node ffff88013f81c720), AE_TIME
> > > ACPI Exception: AE_TIME, Evaluating _BST (20090903/battery-393)

> Could you do a bisect?

In particular, please try the 2.6.31 versio of drivers/acpi/ec.c

thanks,
-Len Brown, Intel Open Source Technology Center


