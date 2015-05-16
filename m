From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/6] ACPI / EC: Update due to recent changes.
Date: Sat, 16 May 2015 02:22:36 +0200
Message-ID: <10548867.PAL3ammWVt@vostro.rjw.lan>
References: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com> <cover.1431670199.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431670199.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, May 15, 2015 02:16:05 PM Lv Zheng wrote:
> This patchset tries to cleanup the EC driver to reflect the recent changes.
> There is a small fix in the patchset to use time_before() instead of
> time_after().
> The last patch removes all non-root-caused MSI quirks so that we may be
> able to identify their root cause if regressions are reported against this
> removal and generate new quirks based on the new code base.
> 
> Lv Zheng (6):
>   ACPI / EC: Update acpi_ec_is_gpe_raised() with new GPE status flag.
>   ACPI / EC: Remove storming threashold enlarging quirk.
>   ACPI / EC: Remove irqs_disabled() check.
>   ACPI / EC: Fix and clean up register access guarding logics.
>   ACPI / EC: Add module params for polling modes.
>   ACPI / EC: Remove non-root-caused busy polling quirks.
> 
>  drivers/acpi/ec.c       |  148 ++++++++++++++++++++++-------------------------
>  drivers/acpi/internal.h |    1 +
>  2 files changed, 69 insertions(+), 80 deletions(-)

All of these make sense to me, so I'm queuing them up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
