From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 00/12] ACPI/IPMI: Fix several issues in the current codes
Date: Wed, 25 Sep 2013 19:54:34 +0200
Message-ID: <3234851.YNvxj0TJEP@vostro.rjw.lan>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52155 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751172Ab3IYRnN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2013 13:43:13 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

On Friday, September 13, 2013 01:13:01 PM Lv Zheng wrote:
> This patchset tries to fix the following kernel bug:
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=46741
> This is fixed by [PATCH 06].
> 
> The bug shows IPMI operation region may appear in a device not under the
> IPMI system interface device's scope, thus it's required to install the
> ACPI IPMI operation region handler from the root of the ACPI namespace.
> 
> The original acpi_ipmi implementation includes several issues that break
> the test process.  This patchset also includes a re-design of acpi_ipmi
> module to make the test possible.
>  
> [PATCH 01-06] are bug-fix patches that can be applied to the kernels whose
>               version is > 2.6.38.  This can be confirmed with:
>               # git tag --contains e92b297c
> [PATCH 07] is a tuning patch for acpi_ipmi.c.
> [PATCH 08-12] are cleanup patches for acpi_ipmi.c and its Kconfig item.
> 
> v2.0
> PATCH 03: Uses timeout mechanism offerred by ipmi_si.
> PATCH 05: Uses kref instead of atomic_t and adds "dead" flag to kill the
>           atomic_read codes in ipmi_flush_tx_msg().
> PATCH 07: Uses kref instead of atomic_t.
> 
> This patchset has passed the test around a fake device accessing IPMI
> operation region fields on an IPMI capable platform.  A stress test of
> module(acpi_ipmi) load/unload has been performed on such platform.  No
> races can be found and the IPMI operation region handler is functioning
> now.  It is not possible to test module(ipmi_si) load/unload as it can't be
> unloaded due to its' transfer flushing implementation.
> 
> Lv Zheng (12):
>   ACPI/IPMI: Fix atomic context requirement of ipmi_msg_handler()
>   ACPI/IPMI: Fix potential response buffer overflow
>   ACPI/IPMI: Fix race caused by the unprotected ACPI IPMI transfers
>   ACPI/IPMI: Fix race caused by the timed out ACPI IPMI transfers
>   ACPI/IPMI: Fix race caused by the unprotected ACPI IPMI user
>   ACPI/IPMI: Fix issue caused by the per-device registration of the
>     IPMI operation region handler
>   ACPI/IPMI: Add reference counting for ACPI IPMI transfers
>   ACPI/IPMI: Cleanup several acpi_ipmi_device members
>   ACPI/IPMI: Cleanup some initialization codes
>   ACPI/IPMI: Cleanup some inclusion codes
>   ACPI/IPMI: Cleanup some Kconfig codes
>   ACPI/IPMI: Cleanup coding styles
> 
>  drivers/acpi/Kconfig     |    3 +-
>  drivers/acpi/acpi_ipmi.c |  594 ++++++++++++++++++++++++++++------------------
>  2 files changed, 367 insertions(+), 230 deletions(-)

Queued up for 3.13, thanks Lv!

