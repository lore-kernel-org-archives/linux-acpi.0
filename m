From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] acpi: thermal: Remove create_workqueue
Date: Tue, 7 Jun 2016 09:13:51 -0500
Message-ID: <20160607141351.GW31708@htj.duckdns.org>
References: <20160607031540.GA15147@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36771 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364AbcFGONx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jun 2016 10:13:53 -0400
Content-Disposition: inline
In-Reply-To: <20160607031540.GA15147@Karyakshetra>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 07, 2016 at 08:45:40AM +0530, Bhaktipriya Shridhar wrote:
> alloc_workqueue replaces deprecated create_workqueue().
> 
> A dedicated workqueue has been used since the workqueue
> acpi_thermal_pm_queue with workitem &tz->thermal_check_work
> (maps to acpi_thermal_check_fn), is involved in thermal zone polling.
> Wallclock time is actually important and getting delayed in handling
> critical temperature event can actually lead to unnecessary hardware
> damage. So while this is not used during memory reclaim, we still want
> forward progress guarantee and be generally snappy in servicing it.
> Hence, WQ_MEM_RECLAIM and WQ_HIGHPRI have been used here.
> 
> Since there are only a fixed number of work items, explicit concurrency
> limit is unnecessary here.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
