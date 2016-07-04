From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [UPDATE PATCH v2 1/3] ACPICA: Events: Introduce acpi_mask_gpe() to implement GPE masking mechanism
Date: Mon, 04 Jul 2016 15:59:07 +0200
Message-ID: <3293670.WgkPNILEVA@vostro.rjw.lan>
References: <cover.1463389639.git.lv.zheng@intel.com> <cover.1466662469.git.lv.zheng@intel.com> <29ae6c9cdef0aa91f3461707c65ebcdee0ff7142.1466662469.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58631 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753403AbcGDNyg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 09:54:36 -0400
In-Reply-To: <29ae6c9cdef0aa91f3461707c65ebcdee0ff7142.1466662469.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, June 23, 2016 03:05:47 PM Lv Zheng wrote:
> (remove acpi_unmask_gpe() from the patch description)
> 
> There is a facility in Linux, developers can control the enabling/disabling
> of a GPE via /sys/firmware/acpi/interrupts/gpexx. This is mainly for
> debugging purposes.
> 
> But many users expect to use this facility to implement quirks to mask a
> specific GPE when there is a gap in Linux causing this GPE to flood. This
> is not working correctly because currently this facility invokes
> enabling/disabling counting based GPE driver APIs:
>  acpi_enable_gpe()/acpi_disable_gpe()
> and the GPE drivers can still affect the count to mess up the GPE
> masking purposes.
> 
> However, most of the IRQ chip designs allow masking/unmasking IRQs via a
> masking bit which is different from the enabled bit to achieve the same
> purpose. But the GPE hardware doesn't contain such a feature, this brings
> the trouble.
> 
> In this patch, we introduce a software mechanism to implement the GPE
> masking feature, and acpi_mask_gpe() are provided to the OSPMs to
> mask/unmask GPEs in the above mentioned situation instead of
> acpi_enable_gpe()/acpi_disable_gpe(). ACPICA BZ 1102. Lv Zheng.
> 
> Link: https://bugs.acpica.org/show_bug.cgi?id=1102
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I've queued up this one and the [2/3] and please see my comments on the [3/3].

Thanks,
Rafael

