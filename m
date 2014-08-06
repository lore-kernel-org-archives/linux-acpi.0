From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/OSL: Remove RCU in the osl.c to avoid dead lock with cpu hot plug
Date: Wed, 06 Aug 2014 21:09:25 +0200
Message-ID: <5565710.HfsfjXfcL3@vostro.rjw.lan>
References: <1407141608-28920-1-git-send-email-tianyu.lan@intel.com> <1655155.Bsn9BIJnyn@vostro.rjw.lan> <53E19175.208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49392 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756263AbaHFSup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2014 14:50:45 -0400
In-Reply-To: <53E19175.208@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 06, 2014 10:22:45 AM Lan Tianyu wrote:
> On 2014=E5=B9=B408=E6=9C=8806=E6=97=A5 09:24, Rafael J. Wysocki wrote=
:
> > On Monday, August 04, 2014 04:40:08 PM Lan Tianyu wrote:

[cut]

> >> @@ -298,29 +298,29 @@ void __iomem *acpi_os_get_iomem(acpi_physica=
l_address phys, unsigned int size)
> >>  {
> >>  	struct acpi_ioremap *map;
> >>  	void __iomem *virt =3D NULL;
> >> +	unsigned long flags;
> >> =20
> >> -	mutex_lock(&acpi_ioremap_lock);
> >> +	spin_lock_irqsave(&acpi_ioremap_lock, flags);
> >=20
> > Why do you need to do _irqsave here?  It was a mutex before, after =
all,
> > so it can't be called from interrupt context.
> >=20
> > In other places below too.
>=20
> Original code uses RCU lock to protect acpi_ioremaps list in the
> acpi_os_read/write_memory() which will be called in apei_read/write()=
=2E
> apei_read/write() will be called in the interrupt from APEI comments.

But acpi_os_get_iomem() won't be called from interrupt context and shou=
ld use
spin_lock_irq() instead of _irqsave.  This also applies to the other pl=
aces
that use the mutex.

> Now replace RCU with acpi_ioremap_lock and the lock will be called in
> the interrupt. So redefine it to spin lock. From history,
> acpi_ioremap_lock was spin lock before adding RCU support.

And it had scalability problems IIRC.

Did you consider using SRCU instead of going back to the spinlock?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
