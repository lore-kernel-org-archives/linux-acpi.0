From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [Regression] Build failure caused by 'cpuidle: makes AMD C1E
	work in acpi_idle'
Date: Tue, 2 Jun 2009 09:01:50 +0800
Message-ID: <20090602010150.GA21166@sli10-desk.sh.intel.com>
References: <200906011858.10575.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48610 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbZFBBBu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Jun 2009 21:01:50 -0400
Content-Disposition: inline
In-Reply-To: <200906011858.10575.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jun 02, 2009 at 12:58:08AM +0800, Frans Pop wrote:
> $ git describe master
> v2.6.30-rc7-227-gd9244b5
>=20
> [...]
> /home/fjp/projects/kernel/linux-2.6/drivers/acpi/processor_idle.c: In=
=20
> function =E2=80=98acpi_processor_power_verify=E2=80=99:
> /home/fjp/projects/kernel/linux-2.6/drivers/acpi/processor_idle.c:617=
:=20
> error: implicit declaration of function =E2=80=98acpi_timer_check_sta=
te=E2=80=99
> /home/fjp/projects/kernel/linux-2.6/drivers/acpi/processor_idle.c: In=
=20
> function =E2=80=98acpi_idle_enter_c1=E2=80=99:
> /home/fjp/projects/kernel/linux-2.6/drivers/acpi/processor_idle.c:839=
:=20
> error: implicit declaration of function =E2=80=98acpi_state_timer_bro=
adcast=E2=80=99
> make[7]: *** [drivers/acpi/processor_idle.o] Error 1
>=20
> Reverting the following two commits fixed the error:
> 87ad57ba cpuidle: makes AMD C1E work in acpi_idle
> 7d60e8ab cpuidle: fix AMD C1E suspend hang
>=20
> (Second one probably was not needed, but done as it looked related.)
Can't reproduce it here with your config, can you double check please?

Thanks,
Shaohua
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
