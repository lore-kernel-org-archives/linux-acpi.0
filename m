From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPI: Battery: add sysfs support
Date: Wed, 15 Aug 2007 17:14:10 +0400
Message-ID: <46C2FC22.60802@gmail.com>
References: <46BE1383.8000205@gmail.com> <200708150047.55528.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:33977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340AbXHONOS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Aug 2007 09:14:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so155919ugf
        for <linux-acpi@vger.kernel.org>; Wed, 15 Aug 2007 06:14:17 -0700 (PDT)
In-Reply-To: <200708150047.55528.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Len Brown wrote:
> On Saturday 11 August 2007 15:52, Alexey Starikovskiy wrote:
>> Hi Len,
>>
>> This is a first try to add sysfs support for ACPI battery.
>> It should apply on top of clean up patches I sent earlier.
>> It lacks alarm support in sysfs, as power_supply class does not support it.
> 
> The check-in comments should describe the sysfs support.
> it is an API that is being created here -- after all.
> 
> thanks,
> -len
> 
No, we are using standard class power_supply and its API. 
So all the documentation is already present in kernel.

Regards,
Alex
