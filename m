From: David Rientjes <rientjes@google.com>
Subject: Re: [rebased-again][PATCH 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Mon, 25 Feb 2013 14:51:30 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1302251450160.4488@chino.kir.corp.google.com>
References: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com> <1361759917-5195-2-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37133 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab3BYWvc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2013 17:51:32 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so2019109pab.15
        for <linux-acpi@vger.kernel.org>; Mon, 25 Feb 2013 14:51:32 -0800 (PST)
In-Reply-To: <1361759917-5195-2-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: liguang <lig.fnst@cn.fujitsu.com>
Cc: tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@sisk.pl, lv.zheng@intel.com, jarkko.sakkinen@intel.com, dave@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

On Mon, 25 Feb 2013, liguang wrote:

> srat table should present only on acpi domain,
> seems mm/ is not the right place for it.
> 
> Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>

You're still missing 01a178a94e8e ("acpi, memory-hotplug: support getting 
hotplug info from SRAT") that was merged at the end of last week.  Instead 
of continuing to rebase perhaps it would be better at this point to ask 
the x86 maintainers to just do the patch for you?
