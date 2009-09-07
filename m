From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] topstar_acpi: add new driver for hotkeys support on Topstar N01
Date: Mon, 7 Sep 2009 16:18:30 -0300
Message-ID: <200909071618.30315.herton@mandriva.com.br>
References: <200909050229.55665.herton@mandriva.com.br> <200909061701.13440.corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:38999 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbZIGTSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 15:18:32 -0400
In-Reply-To: <200909061701.13440.corentin.chary@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org

Em Dom 06 Set 2009, =E0s 12:01:13, Corentin Chary escreveu:
> On Saturday 05 September 2009 07:29:55 you wrote:
> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> > functionality with Topstar N01 netbook. Besides hotkeys there are
> > other functions exposed by its ACPI firmware, but for now only
> > hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> > manufacturer, its website can be currently reached at
> > http://www.topstardigital.cn/
> >=20
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > ---
> >  drivers/platform/x86/Kconfig        |    8 +
> >  drivers/platform/x86/Makefile       |    1 +
> >  drivers/platform/x86/topstar_acpi.c |  301
> >  +++++++++++++++++++++++++++++++++++ 3 files changed, 310 insertion=
s(+), 0
> >  deletions(-)
> >  create mode 100644 drivers/platform/x86/topstar_acpi.c
> >=20
> > I'm attaching here too the gzipped acpidump of Topstar N01, which I=
 based
> >  to do the driver.
>=20
> Hi,
> I think topstar-laptop is a better name:
> $ echo drivers/platforn/x86/*-laptop.c
> asus-laptop.c compal-laptop.c dell-laptop.c eeepc-laptop.c fujitsu-la=
ptop.c=20
> msi-laptop.c panasonic-laptop.c sony-laptop.c
>=20

Ok, will rename it to topstar-laptop.

--=20
[]'s
Herton
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
