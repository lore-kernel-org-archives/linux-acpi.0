From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI warning in 2.6.28-rc1
Date: Tue, 28 Oct 2008 12:40:16 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308580ADBF12C@orsmsx503.amr.corp.intel.com>
References: <b637ec0b0810241509j43a6bfc9q506dc16a612e7f06@mail.gmail.com>
	 <4911F71203A09E4D9981D27F9D8308580AA800C4@orsmsx503.amr.corp.intel.com>
 <b637ec0b0810250257oc9718f0yb6fc9fc2b53e80fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29168 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbYJ1TkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 15:40:19 -0400
In-Reply-To: <b637ec0b0810250257oc9718f0yb6fc9fc2b53e80fc@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Thanks.

The Linux battery driver can in fact handle the buffer where there should be a string, so this warning can be ignored.

The acpidump is very helpful for characterizing the problem, and we are investigating the proper course of action.

Bob


>-----Original Message-----
>From: Fabio Comolli [mailto:fabio.comolli@gmail.com]
>Sent: Saturday, October 25, 2008 2:57 AM
>To: Moore, Robert
>Cc: Linux Kernel Mailing List; ACPI mailing list; Len Brown
>Subject: Re: ACPI warning in 2.6.28-rc1
>
>Here you are.
>Regards,
>Fabio
>
>
>
>On Sat, Oct 25, 2008 at 12:34 AM, Moore, Robert <robert.moore@intel.com>
>wrote:
>> Please send the acpidump for the machine so we can look at the method.
>> Thanks,
>> Bob
>>
>>
>>>-----Original Message-----
>>>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>>>owner@vger.kernel.org] On Behalf Of Fabio Comolli
>>>Sent: Friday, October 24, 2008 3:09 PM
>>>To: Linux Kernel Mailing List
>>>Cc: ACPI mailing list; Len Brown
>>>Subject: ACPI warning in 2.6.28-rc1
>>>
>>>Hi all.
>>>As the subject says:
>>>
>>>ACPI Warning (nspredef-0858): \_SB_.PCI0.LPCB.EC0_.BAT0._BIF: Return
>>>Package type mismatch at index 11 - found Buffer, expected String
>>>[20080926]
>>>
>>>No functional problems so far.
>>>--
>>>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
