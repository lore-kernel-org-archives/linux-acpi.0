From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [linux-pm] [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 2 Jan 2008 09:37:13 +0200
Message-ID: <200801020937.13808.maximlevitsky@gmail.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:60775 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbYABHhT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 02:37:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2490338ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jan 2008 23:37:18 -0800 (PST)
In-Reply-To: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, 2 January 2008 08:59:22 Shaohua Li wrote:
> ACPI defines a hardware signature. BIOS calculates the signature
> according to hardware configure, if hardware changes, the signature will
> change, in this case, S4 resume should fail.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/sleep/main.c |   13 +++++++++++++
>  include/linux/suspend.h   |    5 +++++
>  kernel/power/disk.c       |   21 ++++++++++++++++++---
>  kernel/power/power.h      |    6 +++---
>  kernel/power/swap.c       |   24 +++++++++++++++---------
>  5 files changed, 54 insertions(+), 15 deletions(-)

Once reading the ACPI spec I noticed that ACPI supports this feature
so it is qute nice to implement it, since this will prevent resume from disk what hardware was changed.

But.. how many bioses are broken regarding this feature....

Regards,
	Maxim Levitsky
