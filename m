From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH 0/2]: the patch set to weaken the dependency between ACPI
	video driver and i915 driver
Date: Tue, 14 Apr 2009 11:04:35 +0800
Message-ID: <1239678275.5564.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16804 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZDNDD0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 23:03:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi, All
    the following is the patch set that can weaken the dependency between ACPI video and i915
driver.
    Patch 1/2:  Check whether the acpi video is deferrable only when KMS is enabled
    When the KMS is enabled in kernel configuration, OS will check whether  the acpi video 
driver is deferrable. Otherwise it will continue the current flowchart.

    Patch 2/2:  weaken the tight dependency between the ACPI video driver and i915 driver
    Now there exists the tight dependency between the ACPI video driver and i915 driver. 
If the I915 driver is compiled as built-in module and the acpi video is compiled as module, 
it will fail in the kernel compilation.
    At the same time the acpi video driver must be loaded in order to load
the I915 driver. It is very hack.

    This patch is to weaken the dependency between the ACPI video driver and
i915 driver. But it still can do what we expected.
    a. the i915/acpi_video_register is defined in the video_detect.When the video is selected, 
it will be complied as built-in functions. If the video is not selected, it is defined as 
inline function.
    b. i915_video_register is called by i915 driver. And i915 video flag is set.
    c. acpi_video_register/unregister is called by acpi video driver. The acpi video bus driver
is hooked and the ACPI video flag is set.
    d. When the both flag bits are set, the acpi video bus driver will be registered.


Welcome the comments.
 
Best regards
   Yakui


