From: Ismail Donmez <ismail@pardus.org.tr>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Wed, 27 Sep 2006 10:50:02 +0300
Message-ID: <200609271050.03904.ismail@pardus.org.tr>
References: <20060926135659.GA3685@jnb.gelma.net> <20060926221400.5da1b796.akpm@osdl.org> <200609270204.38970.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:39120 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S965440AbWI0Htt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 03:49:49 -0400
In-Reply-To: <200609270204.38970.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,
27 Eyl 2006 =C3=87ar 09:04 tarihinde, Len Brown =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
[...]
> > > Will sony_acpi ever make it to the mainline? Its very useful for =
new
> > > Vaio models.
>
> Nope, not as it is.  Useful !=3D supportable.
>
> 1. It must not create any files under /proc/acpi
>     This is creating a machine-specific API, which
>     is exactly what we don't want  Nobody can maintain
>     50 machine specific APIs.
>
>     These objects must appear generic and under sysfs
>     as if acpi were not involved in providing them.
>
> 2. its source code shall not live in drivers/acpi
>     it is not part of the ACPI implementation after all --
>     it is a platform specific driver.

Is there a such example code under kernel now, so one could look at it =
and fix=20
sony_acpi driver.

Regards,
ismail

--=20
They that can give up essential liberty to obtain a little temporary sa=
fety=20
deserve neither liberty nor safety.
-- Benjamin Franklin
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
