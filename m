From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
 method
Date: Mon, 15 Mar 2010 01:15:54 +0300
Message-ID: <4B9D601A.3050708@gmail.com>
References: <20091015103122.3853.34760.stgit@thinkpad> <20091015103144.3853.9717.stgit@thinkpad> <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com> <20091017154124.GA31182@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:37259 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934304Ab0CNWQA (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 18:16:00 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1248648fgg.1
        for <Linux-acpi@vger.kernel.org>; Sun, 14 Mar 2010 15:15:58 -0700 (PDT)
In-Reply-To: <20091017154124.GA31182@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, 16 Oct 2009, Alan Jenkins wrote:
>  =20
>> So userspace is supposed to realise that "0" means "this attribute i=
s
>> not supported", as opposed to "I am a brand new battery and don't
>> remember being factory-tested".
>>
>> How about returning -1 for batteries without _BIX?
>>    =20
>
> How about NOT registering attributes that don't exist?  That's the pr=
oper
> way of doing things in sysfs.
>
>  =20
That is going to be too complex (2 duplicated arrays)
> When that's not possible, I'd suggest doing the right thing and retur=
ning an
> error of some sort (ENXIO, ENOTSUP, etc)...
>
>  =20
None of power class members does it, and all ACPI classes are returning
-1 in not-supporting case.

Regards,
Alex.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
