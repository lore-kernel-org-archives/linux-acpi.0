From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Use of ACPI_FLUSH_CPU_CACHE()
Date: Thu, 8 Jan 2009 09:59:10 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580E3A21A3@orsmsx503.amr.corp.intel.com>
References: <4911F71203A09E4D9981D27F9D8308580D926D5F@orsmsx503.amr.corp.intel.com>
 <alpine.LFD.2.00.0812190524350.11043@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62634 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678AbZAHR7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 12:59:38 -0500
In-Reply-To: <alpine.LFD.2.00.0812190524350.11043@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Yes, we came to the same conclusion


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Len Brown
>Sent: Friday, December 19, 2008 2:29 AM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: Use of ACPI_FLUSH_CPU_CACHE()
>
>> I noticed that Linux does not define anything for this macro (in
>aclinux.h)
>>
>> #define ACPI_FLUSH_CPU_CACHE()
>
>Confusing?  Yes.
>A bug?  No.
>
>aclinux.h is like like this:
>
>#ifdef __KERNEL__
>#else                           /* !__KERNEL__ */
>#define ACPI_FLUSH_CPU_CACHE()
>#endif                          /* __KERNEL__ */
>
>ie. that dummy definition is only used in user-mode simulation on Linux.
>
>The real one is in arch/x86/include/asm/acpi.h:
>
>#define ACPI_FLUSH_CPU_CACHE()  wbinvd()
>
>cheers,
>Len Brown, Intel Open Source Technology Center
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
