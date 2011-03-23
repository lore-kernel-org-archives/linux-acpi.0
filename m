From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] ACPI : remove CONFIG_ACPI_PROCFS_POWER and AC/Battery
 procfs I/F
Date: Tue, 22 Mar 2011 23:23:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103222322011.10549@x980>
References: <1300844063.31379.4.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40651 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab1CWDXy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2011 23:23:54 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH004HZQRN35U1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 22 Mar 2011 22:23:50 -0500 (CDT)
In-reply-to: <1300844063.31379.4.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Documentation/feature-removal-schedule.txt |   11 
> drivers/acpi/Kconfig                       |   17 -
> drivers/acpi/Makefile                      |    1 
> drivers/acpi/ac.c                          |  128 
> drivers/acpi/battery.c                     |  326 
> drivers/acpi/cm_sbs.c                      |  105 ---------
> drivers/acpi/sbs.c                         |  331 
>
> 7 files changed, 5 insertions(+), 914 deletions(-)

Do the popular battery applets know how to use sysfs?
We can't delete this code until they do.

thanks,
Len Brown, Intel Open Source Technology Center

