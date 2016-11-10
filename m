From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] acpi/sleep: Use the FADT to prefer Suspend-to-Idle
 instead of S3
Date: Thu, 10 Nov 2016 22:35:58 +0000
Message-ID: <ab47dd374f594d08941fbebf76999be6@ausx13mpc120.AMER.DELL.COM>
References: <1478813718-12521-1-git-send-email-mario.limonciello@dell.com>
 <201611110628.XymssiIE%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:16307 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755639AbcKJWqD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Nov 2016 17:46:03 -0500
In-Reply-To: <201611110628.XymssiIE%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkp@intel.com
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net, luto@kernel.org

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Thursday, November 10, 2016 4:15 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: kbuild-all@01.org; linux-acpi@vger.kernel.org; Len Brown
> <lenb@kernel.org>; Rafael J . Wysocki <rjw@rjwysocki.net>; Andy
> Lutomirski <luto@kernel.org>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>
> Subject: Re: [PATCH] acpi/sleep: Use the FADT to prefer Suspend-to-Idle
> instead of S3
>=20
> Hi Mario,
>=20
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.9-rc4 next-20161110]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/acpi-
> sleep-Use-the-FADT-to-prefer-Suspend-to-Idle-instead-of-S3/20161111-
> 055555
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
> linux-next
> config: i386-randconfig-x006-201645 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    In file included from include/linux/linkage.h:4:0,
>                     from include/linux/kernel.h:6,
>                     from include/linux/delay.h:10,
>                     from drivers/acpi/sleep.c:13:
>    drivers/acpi/sleep.c: In function 'acpi_sleep_init':
> >> drivers/acpi/sleep.c:917:6: error: implicit declaration of function
> 'suspend_to_idle_preferred' [-Werror=3Dimplicit-function-declaration]
>      if (suspend_to_idle_preferred()) {
>          ^
>    include/linux/compiler.h:149:30: note: in definition of macro '__trace=
_if'
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>                                  ^~~~
> >> drivers/acpi/sleep.c:917:2: note: in expansion of macro 'if'
>      if (suspend_to_idle_preferred()) {
>      ^~
>    Cyclomatic Complexity 1
> arch/x86/include/asm/paravirt.h:arch_local_irq_disable
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_sleep_dmi_check
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_sleep_suspend_setup
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_sleep_syscore_init
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_sleep_hibernate_setu=
p
>    Cyclomatic Complexity 9 drivers/acpi/sleep.c:acpi_sleep_tts_switch
>    Cyclomatic Complexity 9 drivers/acpi/sleep.c:acpi_sleep_pts_switch
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:sleep_notify_reboot
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_power_off
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_sleep_prepare
>    Cyclomatic Complexity 1 drivers/acpi/sleep.c:acpi_power_off_prepare
>    Cyclomatic Complexity 5 drivers/acpi/sleep.c:acpi_sleep_state_supporte=
d
>    Cyclomatic Complexity 6 drivers/acpi/sleep.c:acpi_sleep_init
>    cc1: some warnings being treated as errors
>=20
> vim +/suspend_to_idle_preferred +917 drivers/acpi/sleep.c
>=20
>    911			pm_power_off_prepare =3D acpi_power_off_prepare;
>    912			pm_power_off =3D acpi_power_off;
>    913		} else {
>    914			acpi_no_s5 =3D true;
>    915		}
>    916
>  > 917		if (suspend_to_idle_preferred()) {
>    918			sleep_states[ACPI_STATE_S3] =3D 0;
>    919			sleep_states[ACPI_STATE_S1] =3D 0;
>    920		}
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

In v2 I'll resubmit with the test moved into acpi_sleep_suspend_setup(void)=
 so
that this works properly even if CONFIG_ACPI_SLEEP isn't enabled.
I'll look for any other comments however about this approach before I submi=
t v2.

Thanks,
