From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/10] ACPICA: 20150204 Release
Date: Thu, 05 Feb 2015 16:18:17 +0100
Message-ID: <4329858.H5uSlnSK6D@vostro.rjw.lan>
References: <cover.1423119574.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, February 05, 2015 03:19:23 PM Lv Zheng wrote:
> The 20150204 ACPICA kernel-resident subsystem updates are linuxized based
> on the pm/linux-next branch to form this patchset.
> 
> The patchset has passed the following build/boot tests.
> Build tests are performed as follows:
> 1. i386 + default + COFNIG_ACPI=y
> 2. i386 + allyes + CONFIG_ACPI=y
> 3. i386 + default + COFNIG_ACPI=n
> 4. i386 + allyes + CONFIG_ACPI=n
> 5. x86_64 + default + COFNIG_ACPI=y
> 6. x86_64 + allyes + CONFIG_ACPI=y
> 7. x86_64 + default + COFNIG_ACPI=n
> 8. x86_64 + allyes + CONFIG_ACPI=n
> Boot tests are performed as follows:
> 1. i386 + default + COFNIG_ACPI=y
> 2. x86_64 + default + COFNIG_ACPI=y
> Where:
> 1. i386: machine named as "Dell Inspiron Mini 1010"
> 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
> 3. default: kernel configuration with following items enabled:
>    All hardware drivers related to the machines of i386/x86_64
>    All drivers/acpi configurations
>    All platform drivers
> 
> Note that this patchset doesn't include the following patches from the same
> 20150204 release, they will form a seperate patchset to fix the GPE related
> races in the EC driver:
>  Link: https://github.com/acpica/acpica/commit/199cad16
>  Link: https://github.com/acpica/acpica/commit/da9a83e1
> 
> The divergences checking result:
> Before applying (20141107 Release):
>   852 lines
> After applying (20150204 Release):
>   517 lines
> 
> The above data has already counted the race fixes, without the race fixes,
> the divergences checking result is 648 lines.
> 
> David E. Box (4):
>   ACPICA: Events: Fix uninitialized variable
>   ACPICA: Hardware: Cast GPE enable_mask before storing
>   ACPICA: Update Copyright headers to 2015.
>   ACPICA: Update version to 20150204.
> 
> Lv Zheng (6):
>   ACPICA: Events: Back port "ACPICA: Save current masks of enabled GPEs
>     after enable register writes".
>   ACPICA: Events: Remove duplicated sanity check in
>     acpi_ev_enable_gpe().
>   ACPICA: Events: Remove acpi_ev_valid_gpe_event() due to current
>     restriction.
>   ACPICA: Events: Cleanup of resetting the GPE handler to NULL before
>     removing.
>   ACPICA: Events: Cleanup to move acpi_gbl_global_event_handler
>     invocation out of acpi_ev_gpe_dispatch().
>   ACPICA: Events: Cleanup GPE dispatcher type obtaining code.

Series queued up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
