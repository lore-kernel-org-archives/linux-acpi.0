From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [050/121] ACPI / battery: Fix parsing _BIX return value
Date: Tue, 08 Oct 2013 13:17:42 +0800
Message-ID: <52539576.8030706@intel.com>
References: <18659783.iZRLPaKV6J@aoki> <1381098067.2788.37.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26048 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab3JHF1t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Oct 2013 01:27:49 -0400
In-Reply-To: <1381098067.2788.37.camel@deadeye.wl.decadent.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Francisco Castro <fcr@adinet.com.uy>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On 2013=E5=B9=B410=E6=9C=8807=E6=97=A5 06:21, Ben Hutchings wrote:
> On Tue, 2013-10-01 at 01:01 -0300, Francisco Castro wrote:
>> From: Ben Hutchings <ben@decadent.org.uk>
>>> 3.2.51-rc1 review patch.  If anyone has any objections, please let =
me know.
>>>
>>> ------------------
>>> From: Lan Tianyu <tianyu.lan@intel.com>
>>>
>>> commit 016d5baad04269e8559332df05f89bd95b52d6ad upstream.
>>>
>>> The _BIX method returns extended battery info as a package.
>>> According the ACPI spec (ACPI 5, Section 10.2.2.2), the first membe=
r
>>> of that package should be "Revision".  However, the current ACPI
>>> battery driver treats the first member as "Power Unit" which should
>>> be the second member.  This causes the result of _BIX return data
>>> parsing to be incorrect.
>>>
>>> Fix this by adding a new member called 'revision' to struct
>>> acpi_battery and adding the offsetof() information on it to
>>> extended_info_offsets[] as the first row.
> [...]
>> Hello,
>>
>> Before anything, sorry for my broken english, and thank you all for =
reading my=20
>> mail.
>>
>> I noticed this patch, since it happened to be added recently to the =
standard=20
>> ubuntu kernel 3.8.0.31; and these two lines makes the battery module=
 fail with=20
>> laptop (a NEC LZ750/LS) which previously worked. After removing thes=
e two=20
>> lines and recompiling, it worked again.
>>
>> The lines that dmesg is now showing, are:
>>
>> [    2.272970] ACPI Warning: For \_SB_.PCI0.LPCB.EC__.BAT1._BIX: Ret=
urn=20
>> Package is too small - found 19 elements, expected 20 (20121018/nspr=
edef-679)
>> [    2.272985] battery: probe of PNP0C0A:00 failed with error -14
>>
>> I believe a new (working) patch is needed, since this breaks compati=
bility=20
>> with hardware that's somewhat new, and still on sale. I hope this ma=
il is not=20
>> too late, and this can be fixed.
>=20
> You should report this to the Ubuntu kernel maintainers via Launchpad=
 so
> they can make a decision whether to revert this change in their packa=
ged
> kernel.
>=20
> Hopefully Lan Tianyu and other ACPI developers will work out how to f=
ix
> this completely and then that fix can go into later stable updates.

Sorry for later response. Just come back from vacation.

=46rancisco, please attach the output of acpidump on your machine to
bugzilla. Thanks.

https://bugzilla.kernel.org/show_bug.cgi?id=3D60519

>=20
> I only look after the stable 3.2.y branch, so there's little I can do=
 to
> help you beyond this.
>=20
> Ben.
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
