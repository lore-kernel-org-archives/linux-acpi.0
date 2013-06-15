From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 08/16] ACPICA: Update interface to AcpiUtValidAcpiName
Date: Sun, 16 Jun 2013 01:12:53 +0200
Message-ID: <1995327.DORC7jWR3x@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <7443abecbf977754957f6c8af61add225a9f09a6.1369274559.git.lv.zheng@intel.com> <CAJvTdK=dE5-e_Fr8kQ7V+mOEDuO09E5UMDYamZgAsXdxkfMw-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38755 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637Ab3FOXDg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 19:03:36 -0400
In-Reply-To: <CAJvTdK=dE5-e_Fr8kQ7V+mOEDuO09E5UMDYamZgAsXdxkfMw-A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 01:15:16 PM Len Brown wrote:
> I'm okay w/ the content of this patch, but the Subject: was not converted
> from ACPICA syntax to Linux syntax
> 
> AcpiUtValidAcpiName() should be acpi_ut_valid_acpi_char()

Surely acpi_ut_valid_acpi_name()?

I fixed that up when applying the patch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
