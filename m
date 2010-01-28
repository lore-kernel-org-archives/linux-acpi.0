From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: replace acpi_integer by u64
Date: Wed, 27 Jan 2010 23:07:27 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858559B7D31@orsmsx503.amr.corp.intel.com>
References: <1264647199.25564.18.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.1001280148530.8886@localhost.localdomain>
 <1264660969.25564.30.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32804 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab0A1HHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2010 02:07:46 -0500
In-Reply-To: <1264660969.25564.30.camel@minggr.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Agree.

>-----Original Message-----
>From: Lin, Ming M
>Sent: Wednesday, January 27, 2010 10:43 PM
>To: Len Brown
>Cc: Moore, Robert; linux-acpi
>Subject: Re: [PATCH] ACPI: replace acpi_integer by u64
>
>On Thu, 2010-01-28 at 14:49 +0800, Len Brown wrote:
>> do we want to delete it from actypes.h in this patch too?
>
>No,
>
>ACPICA code base has retained this typedef for compatibility with
>existing device driver code in other OS.
>
>So let's keep consistent with ACPICA code base.
>
>Lin Ming
>
>>
>>
>> applied to acpi-test.
>>
>> thanks,
>> Len Brown, Intel Open Source Technology Center
>>

