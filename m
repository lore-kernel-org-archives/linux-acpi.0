From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Wed, 16 Apr 2008 01:55:23 +0400
Message-ID: <4805244B.8060103@suse.de>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com> <48052499.1080406@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:35449 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765744AbYDOVzs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 17:55:48 -0400
In-Reply-To: <48052499.1080406@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Tomas Carnecky wrote:
> Alexey Starikovskiy wrote:
>> Moore, Robert wrote:
>>> I think one of the reasons we introduced ACPI_NATIVE_UINT is that "int"
>>> is in fact not "native" under all compilation models.
>>>
>>> Here is the table from actypes.h
>>>
>>>  * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
>>>  * char      8    8     8     8     8    8
>>>  * short     16   16    16    16    16   16
>>>  * _int32         32
>>>  * int       32   64    32    32    16   16
>>>  * long      64   64    32    32    32   32
>>>  * long long            64    64
>>>  * pointer   64   64    64    32    32   32
>>>
>>>   
>> Sorry, what do you mean by "not native" ?
>> sizeof(int) != sizeof(void *)  or something else?
> 
> On Linux that is not true!
What is not true? Meaning of "native" in our not-so-private discussion?
> From wikipedia on '64-bit':
> Many 64-bit compilers today use the LP64 model (including Solaris, AIX, 
> HP, Linux, Mac OS X, and IBM z/OS native compilers). Microsoft's VC++ 
> compiler uses the LLP64 model.
> 
> So on Linux: sizeof(long) == sizeof(void *), that's why the kernel uses 
> 'long' all over the place instead of 'int'.
These are well known facts, we were struggling through term definitions.

Regards,
Alex.
