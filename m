From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] ACPI: avoid null pointer dereference error
Date: Tue, 26 Mar 2013 14:39:55 +0100
Message-ID: <341083467.AKGvsIY9pv@vostro.rjw.lan>
References: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43118 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933914Ab3CZNc3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:32:29 -0400
In-Reply-To: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, March 25, 2013 10:50:04 AM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix a null pointer deference by acpi_driver_data() if device is
> null. 
> 
> Colin Ian King (2):
>   ACPI / fan: avoid null pointer deference error
>   ACPI / processor_thermal: avoid null pointer deference error
> 
>  drivers/acpi/fan.c               |    8 ++++++--
>  drivers/acpi/processor_thermal.c |   24 ++++++++++++++++++------
>  2 files changed, 24 insertions(+), 8 deletions(-)

Both patches applied to linux-pm.git/linux-next.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
