From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Fri, 17 Apr 2009 12:41:30 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com>
References: <49E8C9A8.5020201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30411 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbZDQTld convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2009 15:41:33 -0400
In-Reply-To: <49E8C9A8.5020201@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Please explain further what this accomplishes. This removes the use of any cache for the acpi operand object? What about performance? That was the major reason the cache was added in the first place.


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Friday, April 17, 2009 11:26 AM
>To: Moore, Robert; Len Brown
>Cc: ACPI Devel Maling List
>Subject: [RFC][PATCH] ACPICA: Drop Operand cache
>
>Hi,
>
>I've played with AcpiOperandObject union and corresponding cache. Removing
>the union does not seem to be viable -- patch easily overcomes .5 meg
>barrier, without any visible change. Dropping only the cache and making all
>individual objects allocated from heap requires smaller number  of changes
>and chould make SLAB/SLUB developers happy.
>
>Regards,
>Alex.
