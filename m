From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Fri, 24 Apr 2009 11:46:31 +0800
Message-ID: <1240544791.3651.82.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
	 <20090423164642.GF495@gamma.logic.tuwien.ac.at>
	 <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
	 <1240535458.3651.63.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0904232156040.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8396 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbZDXDpp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 23:45:45 -0400
In-Reply-To: <alpine.LFD.2.00.0904232156040.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Norbert Preining <preining@logic.at>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, "Zhang, Rui" <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-04-24 at 09:57 +0800, Len Brown wrote:

Hi, Len
    In my test if VIDEO_OUTPUT_CONTROL is not selected, there exists the
following failure:
    >drivers/built-in.o: In function `acpi_video_bus_put_devices':
    >video.c:(.text+0x41307): undefined reference to
`video_output_unregister'
    >drivers/built-in.o: In function `acpi_video_bus_add':
video.c:(.text+0x43024): undefined reference to `video_output_register'
    >make: *** [.tmp_vmlinux1] Error 1

    In order to fix this issue we must select the VIDEO_OUTPUT_CONTROL
when ACPI_VIDEO is selected. 
    I add the following content in drivers/gpu/drm/Kconfig
    >select ACPI_VIDEO if ACPI 
    >select VIDEO_OUTPUT_CONTROL if ACPI_VIDEO
    
    And then it will report that there exits recursive dependency:
ACPI_VIDEO -> VIDEO_OUTPUT_CONTROL -> ACPI_VIDEO

    In fact in current kernel there exists the following dependency:
    ACPI_VIDEO depends on VIDEO_OUTPUT_CONTROL.

    If we delete the ACPI_VIDEO configuration in drivers/acpi/Kconfig,
we can't select the acpi_video configuration when i915 is not used.

    So IMO it is not very good to change the dependency. After changing
the dependency between ACPI_VIDEO and I915, the new issue about
dependency is triggered. 

    Thanks.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

