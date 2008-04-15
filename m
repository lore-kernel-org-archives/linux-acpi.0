From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Wed, 16 Apr 2008 00:39:30 +0400
Message-ID: <48051282.7050006@gmail.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:10659 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYDOUtb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 16:49:31 -0400
Received: by ug-out-1314.google.com with SMTP id z38so783151ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 15 Apr 2008 13:49:30 -0700 (PDT)
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Moore, Robert wrote:
> I think one of the reasons we introduced ACPI_NATIVE_UINT is that "int"
> is in fact not "native" under all compilation models.
>
> Here is the table from actypes.h
>
>  * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
>  * char      8    8     8     8     8    8
>  * short     16   16    16    16    16   16
>  * _int32         32
>  * int       32   64    32    32    16   16
>  * long      64   64    32    32    32   32
>  * long long            64    64
>  * pointer   64   64    64    32    32   32
>
>   
Sorry, what do you mean by "not native" ?
sizeof(int) != sizeof(void *)  or something else?
How does it change applicability as array index?

