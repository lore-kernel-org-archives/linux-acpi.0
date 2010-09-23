From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 5/5] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation
Date: Thu, 23 Sep 2010 17:04:31 +0800
Message-ID: <AANLkTi=-LzZSgk9BYg8z6i5QrbRWPVBYtpqdkvsTc_E_@mail.gmail.com>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
	<1284865235-29920-6-git-send-email-ying.huang@intel.com>
	<20100921124718.GE18991@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50001 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab0IWJEc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Sep 2010 05:04:32 -0400
In-Reply-To: <20100921124718.GE18991@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On Tue, Sep 21, 2010 at 8:47 PM, Andi Kleen <andi@firstfloor.org> wrote=
:
> On Sun, Sep 19, 2010 at 11:00:35AM +0800, Huang Ying wrote:
>> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
>> index 40b01c3..a103963 100644
>> --- a/drivers/acpi/apei/erst.c
>> +++ b/drivers/acpi/apei/erst.c
>> @@ -266,13 +266,27 @@ static int erst_exec_move_data(struct apei_exe=
c_context *ctx,
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int rc;
>> =C2=A0 =C2=A0 =C2=A0 u64 offset;
>> + =C2=A0 =C2=A0 void *src, *dst;
>> +
>> + =C2=A0 =C2=A0 /* ioremap does not work in interrupt context */
>> + =C2=A0 =C2=A0 if (in_interrupt())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
>
> That breaks serialization of machine checks no? If the BIOS uses MOVE=
_DATA
> How about using kmap_atomic instead?

In my test machine, MOVE_DATA is not used. So this does not breaks
serialization of machine checks.

We can not use kmap_atomic or kmap_atomic_pfn here. Because
kmap_atomic_xxx needs struct page, but the address provided by BIOS
may be in E820_RESERVED area, that is, the corresponding page may have
no struct page. Maybe we need another kmap_atomic implementation for
E820_RESERVED area.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
