From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 13/30] ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding
Date: Mon, 08 Aug 2016 22:24:04 +0200
Message-ID: <1940728.OSvgQcsBu1@vostro.rjw.lan>
References: <cover.1470299677.git.lv.zheng@intel.com> <3d86ecd98996bc782a1f4a0bb0c0a0ae2b958df9.1470299677.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42338 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752541AbcHHUSp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Aug 2016 16:18:45 -0400
In-Reply-To: <3d86ecd98996bc782a1f4a0bb0c0a0ae2b958df9.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Thursday, August 04, 2016 04:43:51 PM Lv Zheng wrote:
> Sometimes, the users may require a quirk to be provided from ACPI subsystem
> core to prevent a GPE from flooding. Normally, if a GPE cannot be
> dispatched, ACPICA core automatically prevents the GPE from firing. But
> there are cases the GPE is dispatched by _Lxx/_Exx provided via AML table,
> and OSPM is lacking of the knowledge to get _Lxx/_Exx correctly executed to
> handle the GPE, thus the GPE flooding may still occur.
> 
> This patch provides a quirk mechanism to stop this kind of GPE flooding.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=53071
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/887793
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

I didn't like this patch before and I still don't like it.

Besides, I'd appreciate it if you didn't mix ACPICA release patches with
non-ACPICA ones.

Thanks,
Rafael

