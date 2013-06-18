From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get
 system ACPI tables)
Date: Tue, 18 Jun 2013 18:48:15 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88529@ORSMSX103.amr.corp.intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
	<de987440373d946b6c672cd796aedc93f9390059.1369274559.git.lv.zheng@intel.com>
 <CAJvTdKkx6hfT8M3SOoMYmrwcC0ODGkGYvVaynS6KNXKPoKJFEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43911 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932112Ab3FRSsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2013 14:48:16 -0400
In-Reply-To: <CAJvTdKkx6hfT8M3SOoMYmrwcC0ODGkGYvVaynS6KNXKPoKJFEg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

This patch should contain the basic acpidump code, now portable.

For linux, it would replace the acpidump in the power tools.


> -----Original Message-----
> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> Sent: Wednesday, June 12, 2013 10:08 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get
> system ACPI tables)
> 
> > This utility dumps the system ACPI tables in an ascii format suitable
> > for extraction via the acpixtract utility.
> 
> This commit message does not match the contents of the patch, or explain
> how this patch is related (or not) to the acpidump utility already in the
> kernel tree under tools/power/acpi/acpidump/
> 
> Naked-by: Len Brown <len.brown@intel.com>
