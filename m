From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/OSL: Remove RCU in the osl.c to avoid dead lock
 with cpu hot plug
Date: Thu, 07 Aug 2014 17:31:06 +0800
Message-ID: <53E3475A.9090301@intel.com>
References: <1407141608-28920-1-git-send-email-tianyu.lan@intel.com> <1655155.Bsn9BIJnyn@vostro.rjw.lan> <53E19175.208@intel.com> <5565710.HfsfjXfcL3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5565710.HfsfjXfcL3@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B408=E6=9C=8807=E6=97=A5 03:09, Rafael J. Wysocki wrote:
> On Wednesday, August 06, 2014 10:22:45 AM Lan Tianyu wrote:
>> On 2014=E5=B9=B408=E6=9C=8806=E6=97=A5 09:24, Rafael J. Wysocki wrot=
e:
>>> On Monday, August 04, 2014 04:40:08 PM Lan Tianyu wrote:
>=20
> [cut]
>=20
>>>> @@ -298,29 +298,29 @@ void __iomem *acpi_os_get_iomem(acpi_physica=
l_address phys, unsigned int size)
>>>>  {
>>>>  	struct acpi_ioremap *map;
>>>>  	void __iomem *virt =3D NULL;
>>>> +	unsigned long flags;
>>>> =20
>>>> -	mutex_lock(&acpi_ioremap_lock);
>>>> +	spin_lock_irqsave(&acpi_ioremap_lock, flags);
>>>
>>> Why do you need to do _irqsave here?  It was a mutex before, after =
all,
>>> so it can't be called from interrupt context.
>>>
>>> In other places below too.
>>
>> Original code uses RCU lock to protect acpi_ioremaps list in the
>> acpi_os_read/write_memory() which will be called in apei_read/write(=
).
>> apei_read/write() will be called in the interrupt from APEI comments=
=2E
>=20
> But acpi_os_get_iomem() won't be called from interrupt context and sh=
ould use
> spin_lock_irq() instead of _irqsave.  This also applies to the other =
places
> that use the mutex.

Yes, that's correct. Sorry. I misunderstood what you meant.

>=20
>> Now replace RCU with acpi_ioremap_lock and the lock will be called i=
n
>> the interrupt. So redefine it to spin lock. From history,
>> acpi_ioremap_lock was spin lock before adding RCU support.
>=20
> And it had scalability problems IIRC.
>=20
> Did you consider using SRCU instead of going back to the spinlock?

No, I will have a look at SRCU.

>=20
> Rafael
>=20


--=20
Best regards
Tianyu Lan
