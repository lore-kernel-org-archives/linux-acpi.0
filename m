From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 28/48] thermal: Add event notification to thermal
 framework
Date: Thu, 13 Jan 2011 17:01:16 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF0465410944741961@bgsmsx502.gar.corp.intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
 <201101131207.01290.trenn@suse.de> <201101131214.14677.trenn@suse.de>
 <201101131221.43797.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35315 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756571Ab1AMLb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jan 2011 06:31:56 -0500
In-Reply-To: <201101131221.43797.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Thomas,

Thanks for the Cleanup.

> I wonder why this one got exported at all.
> It's only used in thermal_sys.c for now?
> I hope I didn't oversee a follow up patch in another
> driver which already makes use of it.
> 

There is a patch to add threshold support to hwmon/coretemp.c 
that uses this events. This patch is getting reviewed upstream.

Thanks,
Durga
