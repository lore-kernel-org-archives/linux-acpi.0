From: Marcin Gozdalik <gozdal@gmail.com>
Subject: Re: ACPI Exception
Date: Thu, 30 Apr 2009 12:11:28 +0200
Message-ID: <fab5b76e0904300311u4c70da46if59efa6d167a5820@mail.gmail.com>
References: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
	<1240448177.7661.515.camel@rzhang-dt> <fab5b76e0904230312o2c59d007nb865cff87dbae58e@mail.gmail.com>
	<1240556138.7661.592.camel@rzhang-dt> <fab5b76e0904290251m7d7cb01arae437de5fc944661@mail.gmail.com>
	<1241053606.3640.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:8221 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZD3KLs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2009 06:11:48 -0400
Received: by yx-out-2324.google.com with SMTP id 3so993448yxj.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2009 03:11:48 -0700 (PDT)
In-Reply-To: <1241053606.3640.0.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2009/4/30 yakui_zhao <yakui.zhao@intel.com>
>
> On Wed, 2009-04-29 at 17:51 +0800, Marcin Gozdalik wrote:
> > I am running the modified DSDT for the last 24 hours and the trip
> > point has not been triggered. Sometimes it happen after longer time
> > though.
> > The fixed DSDT does not help for "ACPI: Unable to turn cooling device
> > [ffff88006f851800] 'off'" messages after S3 suspend/resume cycle.
>
> Will you please add the boot option of "acpi.power_nocheck=1" and see
> whether the issue still exists?
> r.kernel.org/majordomo-info.html
>

Yes, the Unable to turn cooling device after resume is still there
with power_nocheck=1.

--
Marcin Gozdalik <gozdal@gmail.com>
