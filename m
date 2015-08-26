From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations.
Date: Wed, 26 Aug 2015 02:08:50 +0200
Message-ID: <1482108.16oMRKLiIY@vostro.rjw.lan>
References: <d2029b78c1e914d0c05b28c406a88057858b8a42.1434001323.git.lv.zheng@intel.com> <05a5a68b209d57c2b2e9e8aba1fa6365ec40c52c.1438924516.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41506 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752090AbbHYXlS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2015 19:41:18 -0400
In-Reply-To: <05a5a68b209d57c2b2e9e8aba1fa6365ec40c52c.1438924516.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, August 12, 2015 11:12:02 AM Lv Zheng wrote:
> It is proven that Windows evaluates _Qxx handlers in a parallel way. This
> patch follows this fact, splits _Qxx evaluations from the NOTIFY queue to
> form a separate queue, so that _Qxx evaluations can be queued up on
> different CPUs rather than being queued up on a CPU0 bound queue.
> Event handling related callbacks are also renamed and sorted in this patch.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=94411
> Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
