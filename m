From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: HP Probook 4510s fan always at high speed
Date: Wed, 31 Mar 2010 20:22:36 +0200
Message-ID: <y2gb170af451003311122p3bcef2acu420470c8a966f603@mail.gmail.com>
References: <4BB38F3C.4040108@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58991 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab0CaSWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2010 14:22:37 -0400
Received: by wwb17 with SMTP id 17so278995wwb.19
        for <linux-acpi@vger.kernel.org>; Wed, 31 Mar 2010 11:22:36 -0700 (PDT)
In-Reply-To: <4BB38F3C.4040108@bigfoot.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Angel_Pe=C3=B1a?= <angelpp@bigfoot.com>
Cc: linux-acpi@vger.kernel.org

2010/3/31 Angel Pe=C3=B1a <angelpp@bigfoot.com>:
> My new HP Probook 4510s with openSuse 11.2 (kernel 2.6.31) or 11.3
> Milestone 4 (kernel 2.6.32) always ends running the fan at high speed=
=2E
> There must be a change in the BIOS because in others HP laptops (nx61=
25,
> nx7300) it didn't occur.
>
> Thanks for you attention.

Did you check "top" to make sure your CPU is not processing something
hardly? Did your userspace downclocked CPU? What is your GPU?

I don't think it's anything ACPI related.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
