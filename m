From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: do not warn if _BQC  does not exist
Date: Wed, 30 Nov 2016 23:29:01 +0100
Message-ID: <9198995.9godKGSKmc@aspire.rjw.lan>
References: <1480408205.2202.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49874 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752078AbcK3Wcg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 17:32:36 -0500
In-Reply-To: <1480408205.2202.5.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, November 29, 2016 04:30:05 PM Zhang Rui wrote:
> From da38c4f4decae22797aa39d5ac8518cada0302e3 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Tue, 29 Nov 2016 16:13:56 +0800
> Subject: [PATCH] ACPI: do not warn if _BQC does not exist
> 
> Starting from ACPI spec 3.0, it's only clarified that _BCM control
> method is required if _BCL is implemented. There is no word
> saying _BQC is required.
> 
> And in ACPI spec 6.1 B.5.4, for _BQC, it is explicitly stated that
> "This optional method returns the current brightness level of a
> built-in display output device. If present, it must be set by
> the platform for initial brightness."
> 
> Thus remove the obsolete warning message.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Rafael

