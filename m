From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] fixes to ACPI subsystem which assumes cpuidle is always enabled.
Date: Wed, 16 Jan 2013 23:49 +0100
Message-ID: <1449747.HgoeXlbhzH@vostro.rjw.lan>
References: <1358288604-24620-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358288604-24620-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad@kernel.org, xen-devel@lists.xensource.com
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 15, 2013 05:23:22 PM Konrad Rzeszutek Wilk wrote:
> Attached are two patches to the ACPI subsystem and the cpuidle drivers.
> 
> The fixes are to deal with the case when cpuidle_disabled returns true
> and we try to hotplug CPUs on/off. 
> 
>  drivers/acpi/processor_idle.c | 3 +++
>  drivers/idle/intel_idle.c     | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Both patches applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
