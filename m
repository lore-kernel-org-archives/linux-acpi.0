From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI / scan: Annotate physical_node_lock in
 acpi_scan_is_offline()
Date: Thu, 16 Apr 2015 13:01:57 -0600
Message-ID: <1429210917.17259.5.camel@misato.fc.hp.com>
References: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com>
	 <5219717.RxvSXtBaZ8@vostro.rjw.lan> <12760195.2odgqTkKju@vostro.rjw.lan>
	 <2181841.0nPiIAbDNm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:37006 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbDPTUn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2015 15:20:43 -0400
In-Reply-To: <2181841.0nPiIAbDNm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Xie XiuQi <xiexiuqi@huawei.com>, guohanjun@huawei.com, hanjun.guo@linaro.org, linux-kernel@vger.kernel.org

On Sat, 2015-04-11 at 01:31 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> acpi_scan_is_offline() may be called under the physical_node_lock
> of the given device object's parent, so prevent lockdep from
> complaining about that by annotating that instance with
> SINGLE_DEPTH_NESTING.
> 
> Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Agreed that the issue is likely with the lock-class.  Assuming Xie's
test goes well (we will need to wait for that :),

Reviewed-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


