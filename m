From: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
Subject: Re: [12/12] acpi: set fake hid
Date: Mon, 25 Sep 2006 12:40:26 +0300
Message-ID: <4517A40A.9090106@kolumbus.fi>
References: <1158918880.11985.88.camel@localhost.localdomain>	 <4513D02A.8020106@kolumbus.fi> <1159176682.5351.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:30897 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1750741AbWIYJih convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Sep 2006 05:38:37 -0400
In-Reply-To: <1159176682.5351.11.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, shaohua.li@intel.com

Zhang Rui wrote:
> On Fri, 2006-09-22 at 14:59 +0300, Mika Penttil=C3=A4 wrote:=20
>  =20
>> +static int acpi_pci_bridge_match(struct acpi_device *device)
>> +{
>> +       acpi_status status;
>> +       acpi_handle handle;
>> +
>> +       /* pci bridge has _PRT but isn't PNP0A03 */
>> +       status =3D acpi_get_handle(device->handle, METHOD_NAME__PRT,=
 &handle);
>> +       if (ACPI_FAILURE(status))
>> +               return -ENODEV;
>> +       if (!acpi_match_ids(device, "PNP0A03"))
>> +               return -ENODEV;
>> +       return 0;
>> +}
>> +
>>
>>
>> You seem to handle pci-pci bridge here incorrectly (returns -ENODEV =
from match to PNP0A03)
>>
>>    =20
> Is there any pci-pci bridge that has a _HID of "PNP0A03"?
>
> thanks,
> --Rui
>
>  =20
Don't know, but isn't the purpose here for acpi_pci_bridge_match() to=20
match pci-pci bridges also? They won't just because they aren't PNP0A03=
=2E

--Mika

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
