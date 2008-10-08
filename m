From: Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si
 2636
Date: Wed, 08 Oct 2008 12:48:36 +0200
Message-ID: <48EC9004.6010105@gmail.com>
References: <48E9F51A.4080107@gmail.com> <48EC5F4B.8020009@gmail.com> <48EC6465.8060200@gmail.com> <48EC7430.1010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:30575 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbYJHKsm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 06:48:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1527040nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2008 03:48:40 -0700 (PDT)
In-Reply-To: <48EC7430.1010001@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Alexey Starikovskiy wrote:
>> This is AML implementation of EC driver... it relies on certain speed
>> of AML interpreter to work properly (look for Noop inserted as delay).
>>
>> It is possible to replace this driver with the native Linux one, which
>> might be
>> more robust, but this involves heavy DSDT hacking.
>>
>> Overall, it is heavily mis-designed BIOS, so don't expect it to be
>> fixed on Linux side.
>>
>> Regards,
>> Alex.
> Please check if making Noop a small delay helps

I've tried the patch with an udelay of 100 but it did not make any
difference. I've also tried raising it to 200 but that created an
unbootable system because one of the ACPI init methods failed.

You are right, this is a really broken BIOS.

I find it odd that only I experience this problem. According to one
site this laptop is the 7:th most popular laptop right now so someone
else should have reported something.


/Thomas Lindroth
