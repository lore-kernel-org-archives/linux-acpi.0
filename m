From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [LKP] Commit ac3ebafa81a makes NHM EX/EP machines hung out since 3.9-rc1
Date: Tue, 02 Apr 2013 02:13:27 +0200
Message-ID: <3665202.iVImCII9RK@vostro.rjw.lan>
References: <20130313022759.GA120840@bee> <15175142.3Xo9lEvds6@vostro.rjw.lan> <515396B7.1060909@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49703 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758487Ab3DBAFx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Apr 2013 20:05:53 -0400
In-Reply-To: <515396B7.1060909@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <len.brown@intel.com>, Changlong Xie <changlongx.xie@intel.com>, linux-acpi@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, lkp@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, March 28, 2013 09:02:47 AM Alex Shi wrote:
> On 03/28/2013 08:40 AM, Rafael J. Wysocki wrote:
> >> > 
> >> > It fixes the problem on my 8 sockets Nehalem-EX that will hang around
> >> > ip_auto_config()
> >> > 
> >> > Tested-by: Yinghai Lu <yinghai@kernel.org>
> >> > 
> >> > Rafael,
> >> > Can you please push this one to Linus tree ?
> >> > As the offending patch was via your tree to upstream.
> > I will if there's no better way to address this issue before -rc6.
> 
> If it can be pushed to upstream, please add:
> 
> Reported-by: LKP project <lkp@linux.intel.com>
> Reported-by: Xie ChanglongX <changlongx.xie@intel.com>

I have applied the patch, but I've modified the changelog.  Please check the
linux-next branch of my tree and see if the commit is what you meant.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
