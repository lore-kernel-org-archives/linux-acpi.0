From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] ACPI thermal: Don't invalidate thermal zone if
 critical trip point is bad
Date: Fri, 19 Feb 2010 02:34:29 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190234100.24628@localhost.localdomain>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
 <alpine.LFD.2.00.1002190132430.24628@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1197219120-1266564870=:24628"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:51611 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab0BSHed (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 02:34:33 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200523VPIVNV5@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Feb 2010 01:34:33 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.1002190132430.24628@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1197219120-1266564870=:24628
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

drivers/acpi/thermal.c:388: warning: unknown conversion type character ¡)¢ in format
drivers/acpi/thermal.c:388: warning: too many arguments for format

--8323328-1197219120-1266564870=:24628--
