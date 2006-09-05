From: Yu Luming <luming.yu@intel.com>
Subject: Re: 2.6.18-rc5 -rc5-mm1: kacpid continuously generating 4% CPU load on HPC nx6325 w/ SUSE 10.1
Date: Tue, 5 Sep 2006 14:47:24 +0800
Message-ID: <200609051447.24820.luming.yu@intel.com>
References: <200609031123.02237.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11908 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965183AbWIEGo6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 02:44:58 -0400
In-Reply-To: <200609031123.02237.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Seyfried <seife@suse.de>

On Sunday 03 September 2006 17:23, Rafael J. Wysocki wrote:
> Hi,
>
>  I'm having a strange issue with the 2.6.18-rc5 and -rc5-mm1 kernels and
>  SUSE 10.1 on HPC nx6325 that kacpid is generating 4% of CPU load (on one
> core) in a continuous manner.
Please try to unload thermal module.

>
>  It sometimes helps if powersaved is restarted, but only for a short time.
>  However, after restarting powersaved the kacpid-generated load sometimes
> jumps to 100% (on one core) and stays on this level.
>
>  At the same time the battery is never reported to be 100% full (it stops
> at ~98% full and loading) and when I tried to unload the battery module,
> rmmod ended up in the D state.
what do you mean by "in the D state"?

-- 
Thanks,
Luming
