From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Fri, 24 Apr 2009 09:10:58 +0800
Message-ID: <1240535458.3651.63.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
	 <20090423164642.GF495@gamma.logic.tuwien.ac.at>
	 <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53655 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbZDXBKH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 21:10:07 -0400
In-Reply-To: <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Norbert Preining <preining@logic.at>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, "Zhang, Rui" <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-04-24 at 03:50 +0800, Len Brown wrote:

Hi, Len
    The issue can be fixed by the patch from Matthew.
    In Matthew's patch the acpi video is also selected when the i915 is
compiled as builtin-kernel module.
    But IMO this is not very good. From the Kconfig file we know that
acpi video driver depends on the following configuration:
    BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL

    If the VIDEO_OUTPUT_CONTROL/BACKLIGHT_CLASS_DEVICE is not selected,
then it will still fail in kernel compilation.

    Thanks.
> 
> http://patchwork.kernel.org/patch/18420/
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

