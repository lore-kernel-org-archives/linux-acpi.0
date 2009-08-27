From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH] ACPICA: fix leak of acpi_os_validate_address
Date: Thu, 27 Aug 2009 13:09:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908271307240.7792@localhost.localdomain>
References: <1250131948.4044.5.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:52404 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbZH0RJz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 13:09:55 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP100MOGP0CBQW0@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Aug 2009 12:09:49 -0500 (CDT)
In-reply-to: <1250131948.4044.5.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

it is easier to apply patches when they do not appear multiple times
in the e-mail message...

why does acpi_os_invalidate_address() need a return value other than void?

applied to acpi-test

thanks,
Len Brown, Intel Open Source Technology Center

