From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 3/5] ACPI, APEI, HEST Fix the unsuitable usage of platform_data
Date: Thu, 23 Sep 2010 17:06:34 +0800
Message-ID: <AANLkTimrmFJE+7VQqRDe+3oj6XbsBTdfOn=B7Whj3dPS@mail.gmail.com>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
	<1284865235-29920-4-git-send-email-ying.huang@intel.com>
	<20100921124308.GC18991@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47000 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0IWJMy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Sep 2010 05:12:54 -0400
In-Reply-To: <20100921124308.GC18991@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Jin Dongming <jin.dongming@np.css.fujitsu.com>

Hi, Andi,

On Tue, Sep 21, 2010 at 8:43 PM, Andi Kleen <andi@firstfloor.org> wrote=
:
> On Sun, Sep 19, 2010 at 11:00:33AM +0800, Huang Ying wrote:
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 343168d..1a3508a 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -137,20 +137,23 @@ static int hest_parse_ghes_count(struct acpi_h=
est_header *hest_hdr, void *data)
>>
>> =C2=A0static int hest_parse_ghes(struct acpi_hest_header *hest_hdr, =
void *data)
>
> hest_hdr is a local variable on the stack.
>
>
>> +
>> + =C2=A0 =C2=A0 rc =3D platform_device_add_data(ghes_dev, &hest_hdr,=
 sizeof(void *));
>> + =C2=A0 =C2=A0 if (rc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
>
> Now you put the address of that local variable in some global data st=
ructure.
>
> And then you likely return and later the access accesses random stack=
 space?

platform_device_add_data will allocate some new memory, and copy
hest_hdr to there, so this is safe.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
