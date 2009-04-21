From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC][PATCH] Delete NextObject from OperandObject common
Date: Tue, 21 Apr 2009 08:41:20 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308582231F7FB@orsmsx503.amr.corp.intel.com>
References: <49EDA8A4.4000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5770 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbZDUPle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 11:41:34 -0400
In-Reply-To: <49EDA8A4.4000206@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Alexey,

We are putting together the next release of ACPICA, it will take a couple of days for me to get back to you.

Thanks,
Bob


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:aystarik@gmail.com]
>Sent: Tuesday, April 21, 2009 4:06 AM
>To: Moore, Robert; Len Brown; ACPI Devel Maling List
>Subject: [RFC][PATCH] Delete NextObject from OperandObject common
>
>Hi,
>
>Here is one more optimization of OperandObject made possible by previous
>patch.
>Size of Integer shrinks by 1/3
>
>Regards,
>Alex.
