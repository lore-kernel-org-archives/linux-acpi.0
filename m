From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 05/15] ACPICA: Fixes call depth check caused divergences.
Date: Tue, 27 Nov 2012 03:52:18 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94828D4CEB3@FMSMSX108.amr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <803c2ff182470d217b5aac724abbfa853558873a.1353491653.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:9181 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933067Ab2K0DwU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2012 22:52:20 -0500
In-Reply-To: <803c2ff182470d217b5aac724abbfa853558873a.1353491653.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> The ACPICA uses a call depth check mechnism by wrapping the return statements.
> This patch fixes divergences caused by this mechanism.

There is 1 line that does this, and that is fine.

The rest of the patch adds ()'s to return statements.
I'm fine with ACPICA's divergence from official Linux style on that one,
but it should really do that in a separate patch (next time).

thanks,
-Len

