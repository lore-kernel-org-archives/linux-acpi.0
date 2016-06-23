From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: thermal: Remove create_workqueue
Date: Thu, 23 Jun 2016 02:37 +0200
Message-ID: <36677760.GlRjyGeQ5Q@vostro.rjw.lan>
References: <20160607031540.GA15147@Karyakshetra> <20160607141351.GW31708@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56252 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750787AbcFWAcl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 20:32:41 -0400
In-Reply-To: <20160607141351.GW31708@htj.duckdns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, June 07, 2016 09:13:51 AM Tejun Heo wrote:
> On Tue, Jun 07, 2016 at 08:45:40AM +0530, Bhaktipriya Shridhar wrote:
> > alloc_workqueue replaces deprecated create_workqueue().
> > 
> > A dedicated workqueue has been used since the workqueue
> > acpi_thermal_pm_queue with workitem &tz->thermal_check_work
> > (maps to acpi_thermal_check_fn), is involved in thermal zone polling.
> > Wallclock time is actually important and getting delayed in handling
> > critical temperature event can actually lead to unnecessary hardware
> > damage. So while this is not used during memory reclaim, we still want
> > forward progress guarantee and be generally snappy in servicing it.
> > Hence, WQ_MEM_RECLAIM and WQ_HIGHPRI have been used here.
> > 
> > Since there are only a fixed number of work items, explicit concurrency
> > limit is unnecessary here.
> > 
> > Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Patch applied, thanks!

