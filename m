From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi debug changes cause compiling error
Date: Sat, 05 Jan 2013 00:40:54 +0100
Message-ID: <2786753.tv5GFuENqq@vostro.rjw.lan>
References: <CAE9FiQWgjfHBHfaqHecJcB_NRa3dC0sm=Vug7FZkA=-jCv=j0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:60534 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963Ab3ADXfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jan 2013 18:35:17 -0500
In-Reply-To: <CAE9FiQWgjfHBHfaqHecJcB_NRa3dC0sm=Vug7FZkA=-jCv=j0Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, January 04, 2013 02:53:24 PM Yinghai Lu wrote:
> drivers/acpi/processor_driver.c: In function =E2=80=98acpi_processor_=
get_info=E2=80=99:
> drivers/acpi/processor_driver.c:351:2: error: =E2=80=98else=E2=80=99 =
without a previous =E2=80=98if=E2=80=99
> drivers/acpi/processor_driver.c: In function =E2=80=98is_processor_pr=
esent=E2=80=99:
> drivers/acpi/processor_driver.c:674:2: error: =E2=80=98else=E2=80=99 =
without a previous =E2=80=98if=E2=80=99
> make[1]: *** [drivers/acpi/processor_driver.o] Error 1

I'm not sure what changes you mean and what .config you're trying to bu=
ild.

I don't get those errors from my .configs, and they haven't been report=
ed by
people who build linux-next too.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
