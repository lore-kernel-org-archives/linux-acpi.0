From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA release 20101013 linuxized patches
Date: Mon, 18 Oct 2010 01:31:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010180130360.3295@localhost.localdomain>
References: <1287366571.6530.3026.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:39675 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0JRFb5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2010 01:31:57 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAH00AXA0OSO1G5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 18 Oct 2010 00:31:46 -0500 (CDT)
In-reply-to: <1287366571.6530.3026.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

patch 5 doesn't look quite right,
because it leaves both

#define ACPI_BITMASK_PCIEXP_WAKE_STATUS         0x4000  /* ACPI 3.0 */
and
#define ACPI_BITMASK_PCIEXP_WAKE_DISABLE        0x4000  /* ACPI 3.0 */

in aclocal.h

If we're going to re-name what the original patch did,
then we should finsh the job and delete the original name, yes?

thanks,
Len Brown, Intel Open Source Technology Center

