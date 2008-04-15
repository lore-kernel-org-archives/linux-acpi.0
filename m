From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 15 Apr 2008 15:20:22 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B32A4F52@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com> <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com> <48051A27.6040004@suse.de> <9D39833986E69849A2A8E74C1078B6B32A4E98@orsmsx415.amr.corp.intel.com> <48052605.9000700@dbservice.com> <480524B5.90807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41344 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbYDOWUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 18:20:24 -0400
Content-class: urn:content-classes:message
In-Reply-To: <480524B5.90807@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, Tomas Carnecky <tom@dbservice.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

We probably need to differentiate between "ACPICA" and "ACPICA on Linux"

ACPICA needs to be highly portable, across different C compilers,
machine architectures, and operating systems.

To the matter at hand, it is of course nice to have an integer data type
that is the same as the native bit width of the machine/mode. This is
the same definition as the "size_t" type, is it not?

"long" is not 64-bit under LLP64, which ACPICA claims to support.

>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Tuesday, April 15, 2008 2:57 PM
>To: Tomas Carnecky
>Cc: Moore, Robert; Alexey Starikovskiy; Len Brown; linux-
>acpi@vger.kernel.org
>Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
>packages
>
>Tomas Carnecky wrote:
>> Moore, Robert wrote:
>>> Yes, ACPI_NATIVE_UINT has issues with printf because there is
>>> unfortunately no printf formatting operator other than %p that goes
32
>>> bits in 32-bit mode and 64 bits in 64-bit mode. I think there may be
>>> cases in ACPICA where we just cast an ACPI_NATIVE_UINT to a pointer
to
>>> use it with printf.
>>
>> What's wrong with '%l'? The kernel printf seems to support it, and
the
>> printf manpage says:
>>
>> A following integer conversion corresponds to a long int or unsigned
>> long int argument.
>>
>> And since long is 32bit on 32bit platforms and 64bit on 64bit
platforms,
>> it should work out fine. Or did I miss something?
>Yes. You missed the fact that long is not 64 bit on Windows 64, and
ACPICA
>appears to
>care about that.
>
>Regards,
>Alex.
