From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: how to debug a kernel that does not power off?
Date: Thu, 25 Mar 2010 11:39:44 +0300
Message-ID: <4BAB2150.3020306@gmail.com>
References: <4BAAE755.9090509@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:51664 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab0CYIjs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2010 04:39:48 -0400
Received: by fxm23 with SMTP id 23so835258fxm.21
        for <linux-acpi@vger.kernel.org>; Thu, 25 Mar 2010 01:39:47 -0700 (PDT)
In-Reply-To: <4BAAE755.9090509@maroy.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Cc: linux-acpi@vger.kernel.org

Hi,

Most probably, you have ACPI disabled either in the BIOS or in the
kernel (command line or compiled out). Please check if it is enabled.

Regards,
Alex.

=C3=81kos Mar=C3=B3y =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>
> This might be a lame question, but: how would I debug a kernel that
> simply does not power off a machine? When powering off, on the consol=
e I
> get to the message: [...] Poweroff.
>
> but then, the machine actually does not power off. This is an HP Envy=
 15
> laptop using an intel i7 CPU, and kernel 2.6.32.8..10.
>
> I tried to read up on all sorts of documentation, but could not get m=
ore
> debug info out of the kernel :(
>
> any pointers would be welcome..
>
>
> Akos
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
