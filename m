From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: AcpiGetSleepTypeData: Reduce warnings
Date: Sat, 24 Oct 2015 15:45:20 +0200
Message-ID: <2891538.6pWKmWnizq@vostro.rjw.lan>
References: <1445534238-30447-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47708 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751543AbbJXNQ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Oct 2015 09:16:27 -0400
In-Reply-To: <1445534238-30447-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <Robert.Moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>

On Thursday, October 22, 2015 01:17:18 PM Prarit Bhargava wrote:
> From: Robert Moore <Robert.Moore@intel.com>
> 
> ACPICA commit 7bb77313091e52a846df4c9c2bea90be31bfb9d8
> 
> Eliminate warnings for "not found" _Sx errors, since these
> are optional. Original NOT_FOUND status is still returned.
> 
> Original changes by Prarit Bhargava.
> ACPICA BZ 1208.
> 
> Before patch:
> 
> [prarit@prarit linux]$ dmesg | grep "Sleep State"
> ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20130517/hwxface-571)
> ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130517/hwxface-571)
> 
> After patch:
> [prarit@prarit linux]$ dmesg | grep "Sleep State"
> [prarit@prarit linux]$
> 
> Cc: Robert Moore <Robert.Moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

I'll wait until this comes to me from upstream ACPICA.

Thanks,
Rafael

