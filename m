From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Check for BIOS bugs - Original Subject: Re: [PATCH 23/70] ACPICA: Workaround for reversed _PRT entries from BIOS
Date: Thu, 17 Jul 2008 13:31:25 -0700
Message-ID: <960B77DF2E6D974DBE24FD066EAEE8DAEA9BA8@azsmsx422.amr.corp.intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org> <48738A65.9060905@linux.intel.com> <960B77DF2E6D974DBE24FD066EAEE8DAD90886@azsmsx422.amr.corp.intel.com> <200807091051.57322.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15486 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758204AbYGQUb1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 16:31:27 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200807091051.57322.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Huang Cheng <cheng.huang@intel.com>, firmwarekit-discuss@bughost.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


>> I'm not excited about maintaining
>> maintaining linux-as-a-firmware-diagnostic --
>> particularly when...

>Above is not for ACPI only. But ACPI is probably a candidate 
>which should make use of it.

Sure, there may be justification for doing something like this
in the kernel, but the issue that started this thread isn't it.

The issue that started this thread can be diagnosed by user-space
in linuxfirmwarekit.  Multiple machines have this bug, which means
that it is "common industry practice" and the kernel has to work
around it (silently) if we like it or not.
ie. the issue, now that it is debugged and worked around,
is effectly just firmware lint.

thanks,
-Len
