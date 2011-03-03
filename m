From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: Patch[1/1]:ThermalFramework:Fix_crash_during_hwmon_unregister
Date: Thu, 3 Mar 2011 15:17:27 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF04654109472D00C5@bgsmsx502.gar.corp.intel.com>
References: <D6D887BA8C9DFF48B5233887EF046541094482EE4F@bgsmsx502.gar.corp.intel.com>
 <alpine.LFD.2.02.1103021950390.12344@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18785 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab1CCJrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2011 04:47:33 -0500
In-Reply-To: <alpine.LFD.2.02.1103021950390.12344@x980>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Len,

> i think you may have some problems at
> unregister_hwmon_device:
> 
> because we unconditionally device_remove_file() there,
> even as the associated device_create_files failed.

Thanks for pointing it out. I missed it.
Shall send an appropriate patch.

> 
> please send just 1 copy of a patchin email,
> and remember, as funky as it sounds, the comments
> that are to be excluded from the check-in comment
> go below the first '---'

Shall take care of it from now on.

Thanks,
Durga
