From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][BUG] fix bug in ACPI based CPU hotplug
Date: Tue, 7 Mar 2006 23:35:07 -0800
Message-ID: <20060307233507.6ad0858f.akpm@osdl.org>
References: <440E8723.7030008@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:26780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751120AbWCHHhA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 02:37:00 -0500
In-Reply-To: <440E8723.7030008@soft.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com> wrote:
>
> This patch fixes a serious bug in ACPI based CPU hotplug code. Because
>  of this bug, ACPI based CPU hotplug will always fail if NR_CPUS is
>  equal to or more than 255.

Looks rather similar to
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/broken-out/acpi-signedness-fix-2.patch
;)

I think they're functionally equivalent - the only difference is the ==-1
versus <0 comparisons.

