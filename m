From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Protect cpu map updates from ACPI processor
Date: Tue, 13 Aug 2013 02:43:33 +0200
Message-ID: <2206062.QmFJav0XuL@vostro.rjw.lan>
References: <1376322354-13026-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376322354-13026-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, isimatu.yasuaki@jp.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

On Monday, August 12, 2013 09:45:52 AM Toshi Kani wrote:
> CPU system maps are protected with reader/writer locks.  The reader
> lock, put_online_cpus(), assures that the maps are not updated while
> holding the lock.  The writer lock, cpu_hotplug_begin(), is used to
> udpate the cpu maps along with cpu_maps_update_begin().
> 
> However, the ACPI processor handler updates the cpu maps without
> holding the the writer lock.  This patchset fixes this problem.
> 
> ---
> The patchset is based on linux-next of the pm tree.

Basically looks OK to me, but I'd just merge the patches together,
because the [2/2] is the very reason for the change made by [1/2].

Also it would be good to mention the actual scenario that may lead
to problems with that.

Thanks,
Rafael


> ---
> Toshi Kani (2):
>  CPU hotplug: Export cpu_hotplug_begin() interface
>  ACPI: Acquire writer lock to update cpu maps
> 
> ---
>  drivers/acpi/acpi_processor.c | 21 ++++++++++++++++-----
>  include/linux/cpu.h           |  2 ++
>  kernel/cpu.c                  |  4 ++--
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
