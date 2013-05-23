From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [rebased-again][PATCH 0/4] acpi: do some changes for numa info
Date: Thu, 23 May 2013 08:25:01 +0800
Message-ID: <1369268701.5142.156.camel@liguang.fnst.cn.fujitsu.com>
References: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:53211 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3EWAZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 May 2013 20:25:10 -0400
In-Reply-To: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: hpa@zytor.com, pavel@ucw.cz, rjw@sisk.pl, lv.zheng@intel.com, jarkko.sakkinen@intel.com, dave@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

ping ...

again.

=E5=9C=A8 2013-02-25=E4=B8=80=E7=9A=84 10:38 +0800=EF=BC=8Cliguang=E5=86=
=99=E9=81=93=EF=BC=9A
> just do some trivial changes to make acpi's numa info
> operation more cleaner.
>=20
> ChangeLog
>=20
> v3->v4
>  1.fix srat_disabled function
>  spotted by Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>=20
> v2->v3
>  1. rebase on linux-next
>  2. bring back lost Makefile changes
>  spotted by David Rientjes <rientjes@google.com>
>  spotted by Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>=20
> v1->v2
>  1. fix-up several coding issues
>  2. finish srat.c change
>  spotted by David Rientjes <rientjes@google.com>
>=20
> Li Guang (4)
> 	 acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
> 	 numa: avoid export acpi_numa variable
> 	 acpi: add clock_domain field to acpi_srat_cpu_affinity
> 	 remove include asm/acpi.h in process_driver.c
>=20
> arch/x86/include/asm/acpi.h     | 2 +-
> arch/x86/kernel/acpi/Makefile   | 1 +
> arch/x86/kernel/acpi/srat.c     | 299 +++++++++++++++++++++++++++++++=
++++++++++
> arch/x86/mm/Makefile            | 1 -
> arch/x86/mm/numa.c              | 2 +-
> arch/x86/mm/srat.c              | 278 -------------------------------=
----------
> arch/x86/xen/enlighten.c        | 2 +-
> drivers/acpi/processor_driver.c | 1 -
> include/acpi/actbl1.h           | 2 +-
> 9 files changed, 296 insertions(+), 292 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/srat.c
>  delete mode 100644 arch/x86/mm/srat.c
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
