From: Tony <tony.makkiel@daqri.com>
Subject: Re: Any acpi_device_id naming conventions to follow?
Date: Tue, 28 Jun 2016 13:17:07 +0100
Message-ID: <57726AC3.3030002@daqri.com>
References: <57710FCF.3090908@daqri.com>
 <CAJZ5v0jcovfU_8tnG4jkPuGJCgDQ50aAhooFqxcnhdTsBeCpvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34847 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbcF1MRJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2016 08:17:09 -0400
Received: by mail-wm0-f43.google.com with SMTP id v199so137198668wmv.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2016 05:17:09 -0700 (PDT)
In-Reply-To: <CAJZ5v0jcovfU_8tnG4jkPuGJCgDQ50aAhooFqxcnhdTsBeCpvw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Thank you Rafael.

On 28/06/16 13:05, Rafael J. Wysocki wrote:
> On Mon, Jun 27, 2016 at 1:36 PM, Tony <tony.makkiel@daqri.com> wrote:
>> Hi all,
>>          Is there a naming convention to follow on ACPI device names
>> (acpi_device_id) for device drivers?
>
> Yes, there is.
>
> An ACPI device ID consists of four (upper case) characters (prefix)
> followed by four hex digits.
>
> A PNP device ID consists of three (upper case) characters (prefix)
> followed by four hex digits.
>
> In either case the prefix has to be registered for the device ID to be
> valid.  Once the prefix has been registered, the digits following the
> prefix are allocated by the prefix owner (so as to avoid collisions).
>
> Please read http://www.uefi.org/PNP_ACPI_Registry to learn about the
> prefix registration process and other details.
>
>> For TI led lp3952, I would otherwise name it as "lp3952". But in order to
>> follow  ACPI/PNP device ID convention, it has to be 7 or 8 char long. So is
>> "TLP3952" a valid name?
>>
>> Should the name be registered before it can be used? If it has to be
>> registered, is there a subset of characters which can be used without
>> registration?
>
> There is a special device ID PRP0001 that can be used if there is no
> proper ACPI/PNP device ID registered for the device.  In that case,
> the ACPI device object using PRP0001 as its ID needs to contain a _DSD
> object returning a "compatible" property of the device with a DT
> compatible string as a value (please see
> http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> for the format specification).  The driver only needs to specify a DT
> compatible string to be matched against that device then.
>
> However, that convention only works with Linux at the moment, so it
> really is recommended to use proper ACPI/PNP device IDs with your
> devices.
>
>>  From a little bit of googling, I found there is an ACPI ID 'TXNW' for TI,
>> http://www.uefi.org/ACPI_ID_List?search=texas
>>
>> So should the device name be "TXNW3952"?
>
> Depending on who owns the "TXNW" prefix.  If you can ask them to
> allocate the number following the prefix for you, that should be fine.
>
> That said it may not be necessary to add ACPI device IDs to your
> driver just yet.  For prototyping and development you can use the
> "PRP0001+compatible" convention described above and when you know what
> the final ACPI/PNP ID of the device is going to be, you can add it to
> the driver at that time (ie. later).
>
> Thanks,
> Rafael
>
