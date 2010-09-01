From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI / ACPICA: Defer enabling of runtime GPEs (v2)
Date: Wed, 1 Sep 2010 09:17:13 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AEE0B9B3@orsmsx503.amr.corp.intel.com>
References: <201008290110.56740.rjw@sisk.pl>
 <201008301400.45591.bjorn.helgaas@hp.com> <201008302309.11082.rjw@sisk.pl>
 <201008312235.49410.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24397 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab0IAQRP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2010 12:17:15 -0400
In-Reply-To: <201008312235.49410.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Rafael,

The wake/runtime GPE issue has stirred up some interest with our BIOS team. I'm working on that right now, will begin to look at your changes soon.

Thanks,
Bob


>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>Sent: Tuesday, August 31, 2010 1:36 PM
>To: Moore, Robert
>Cc: Bjorn Helgaas; Matthew Garrett; Brown, Len; Len Brown; Lin, Ming M;
>ACPI Devel Maling List
>Subject: [PATCH] ACPI / ACPICA: Defer enabling of runtime GPEs (v2)
>
>On Monday, August 30, 2010, Rafael J. Wysocki wrote:
>> On Monday, August 30, 2010, Bjorn Helgaas wrote:
>> > On Saturday, August 28, 2010 05:10:56 pm Rafael J. Wysocki wrote:
>> > > Bob, Matthew,
>> > >
>> > > The patch below implements the idea we've been recently discussing
>off-list,

