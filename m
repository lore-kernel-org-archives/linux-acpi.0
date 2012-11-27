From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 05/15] ACPICA: Fixes call depth check caused divergences.
Date: Tue, 27 Nov 2012 05:30:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD37C7@SHSMSX101.ccr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <803c2ff182470d217b5aac724abbfa853558873a.1353491653.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D4CEB3@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27778 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2K0FbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Nov 2012 00:31:03 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828D4CEB3@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Yes, they can be split into 2 patches.
Thanks for the suggestions.

Best regards/Lv Zheng

> -----Original Message-----
> From: Brown, Len
> Sent: Tuesday, November 27, 2012 11:52 AM
> To: Zheng, Lv; Wysocki, Rafael J
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: [PATCH 05/15] ACPICA: Fixes call depth check caused divergences.
> 
> > The ACPICA uses a call depth check mechnism by wrapping the return
> statements.
> > This patch fixes divergences caused by this mechanism.
> 
> There is 1 line that does this, and that is fine.
> 
> The rest of the patch adds ()'s to return statements.
> I'm fine with ACPICA's divergence from official Linux style on that one, but it
> should really do that in a separate patch (next time).
> 
> thanks,
> -Len

