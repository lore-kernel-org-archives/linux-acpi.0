From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [2.6.29-rc5 ACPI] truncated dsobject list...
Date: Tue, 17 Feb 2009 10:48:20 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858149BBB4F@orsmsx503.amr.corp.intel.com>
References: <6278d2220902170831n3801a935x578b5dff64d00c62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15060 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbZBQSsf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 13:48:35 -0500
In-Reply-To: <6278d2220902170831n3801a935x578b5dff64d00c62@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

>ACPI Warning (dsobject-0502): Package List length (6) larger than
>NumElements count (4), truncated

This simply means that in one of the ACPI tables, a Package object was found that was declared to have 6 items. However, when parsing the package, the interpreter only found 4 items.

It's a BIOS issue, but probably not serious unless there really is supposed to be 6 items.


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Daniel J Blueman
>Sent: Tuesday, February 17, 2009 8:32 AM
>To: linux-acpi@vger.kernel.org; Linux Kernel
>Subject: [2.6.29-rc5 ACPI] truncated dsobject list...
>
>With 2.6.29-rc5 on an Intel S5000PAL server (BIOS
>S5000.86B.10.60.0091.100920081631), we see ACPI object list truncation
>[1]. Does it make sense to increase the default element allocation?
>
>Many thanks,
>  Daniel
>
>--- [1]
>
>ACPI: EC: Look up EC in DSDT
>ACPI Warning (dsobject-0502): Package List length (6) larger than
>NumElements count (4), truncated
>[20081204]
>--
>Daniel J Blueman
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
