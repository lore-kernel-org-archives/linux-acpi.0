From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 27 Feb 2015 16:37:10 +0800
Message-ID: <54F02CB6.2090508@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <54EFE282.1090305@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39523 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbbB0Ihc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2015 03:37:32 -0500
Received: by pablf10 with SMTP id lf10so21032374pab.6
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2015 00:37:32 -0800 (PST)
In-Reply-To: <54EFE282.1090305@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi Timur,

On 2015=E5=B9=B402=E6=9C=8827=E6=97=A5 11:20, Timur Tabi wrote:
> On 02/25/2015 02:39 AM, Hanjun Guo wrote:
>> Changes since v8:
>
> I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after
> calling the UEFI boot time services exit function.  That is, this lin=
e:
>
> status =3D sys_table->boottime->exit_boot_services(handle, mmap_key);
>
> in allocate_new_fdt_and_exit_boot() gets called, and then soon after =
it
> returns, the kernel crashes.  It's really early because the UEFI
> exception handler is called.
>
> I did not have this problem with v8 patchset on 3.19.

I tested this patch set on FVP base model with UEFI, and booted ok.
Can you boot the system without this ACPI patch set?

>
>
> Also, you still have a couple whitespace problems in these patches:
>
> Applying: ARM64 / ACPI: additions of ACPI documentation for arm64
> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:607: new blank l=
ine
> at EOF.
> +
> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:844: new blank l=
ine
> at EOF.
> +
> warning: 2 lines add whitespace errors.
> Applying: Documentation: ACPI for ARM64
> /local/mnt/workspace/linux.0/.git/rebase-apply/patch:517: new blank l=
ine
> at EOF.
> +
> warning: 1 line adds whitespace errors.

Weired, When I checked the patch locally there were no whitespace
problems:

=2E/scripts/checkpatch.pl 0020-Documentation-ACPI-for-ARM64.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
#23:
new file mode 100644

WARNING: use relative pathname instead of absolute in changelog text
#25:
--- /dev/null

total: 0 errors, 2 warnings, 506 lines checked

0020-Documentation-ACPI-for-ARM64.patch has style problems, please revi=
ew.

=2E/scripts/checkpatch.pl=20
0021-ARM64-ACPI-additions-of-ACPI-documentation-for-arm64.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
#32:
new file mode 100644

WARNING: use relative pathname instead of absolute in changelog text
#34:
--- /dev/null

WARNING: use relative pathname instead of absolute in changelog text
#634:
--- /dev/null

total: 0 errors, 3 warnings, 825 lines checked

0021-ARM64-ACPI-additions-of-ACPI-documentation-for-arm64.patch has=20
style problems, please review.

Can you provide me the exact line of code which have whitespace problem=
s?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
