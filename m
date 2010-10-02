From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/4] ACPI fan: remove deprecated procfs I/F
Date: Fri, 01 Oct 2010 21:43:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010012143140.2293@localhost.localdomain>
References: <1285965584.2111.3745.camel@rui>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:62894 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0JBBn4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2010 21:43:56 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9N00GJT3H7MEI0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 01 Oct 2010 20:43:56 -0500 (CDT)
In-reply-to: <1285965584.2111.3745.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Remove deprecated ACPI Fan driver procfs interface.
> New sysfs I/F is available at /sys/class/thermal/cooling_devicecX/

Here we want to point out that we select CONFIG_THERMAL
from ACPI_FAN, and we want to point out how long we
have been doing that.

thanks,
Len Brown, Intel Open Source Technology Center

