From: Jiri Kosina <jikos@jikos.cz>
Subject: RE: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Date: Sat, 26 Aug 2006 17:39:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608261737490.29284@twin.jikos.cz>
References: <EB12A50964762B4D8111D55B764A8454800AF0@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:2688 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932468AbWHZPkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Aug 2006 11:40:04 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A8454800AF0@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, 25 Aug 2006, Pallipadi, Venkatesh wrote:

> I don't seem to be able to reproduce this on my T40 laptop. Can you
> please send me the following: 1) Output of acpidump (from latest pmtools
> here: http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ )
> 2) dmesg and cat /proc/acpi/processor/*/* output without this patch.

http://www.jikos.cz/jikos/junk/ACPIDUMP
http://www.jikos.cz/jikos/junk/DMESG
http://www.jikos.cz/jikos/junk/PROC_ACPI

These are from stock 2.6.18-rc4 kernel. 

-- 
JiKos.
