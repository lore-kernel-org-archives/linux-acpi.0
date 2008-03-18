From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: In function `ata_acpi_associate': undefined reference
 to `register_hotplug_dock_device'
Date: Tue, 18 Mar 2008 15:16:24 +0900
Message-ID: <47DF5E38.3030007@gmail.com>
References: <47DEC970.2050402@m3y3r.de> <47DECD54.5060202@m3y3r.de> <200803172357.54253.lenb@kernel.org> <200803180011.49190.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:4813 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYCRGQd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Mar 2008 02:16:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6767372wah.23
        for <linux-acpi@vger.kernel.org>; Mon, 17 Mar 2008 23:16:33 -0700 (PDT)
In-Reply-To: <200803180011.49190.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Meyer <thomas@m3y3r.de>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org, Adrian Bunk <bunk@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jeff@garzik.org

Len Brown wrote:
> Subject: fix ATA_ACPI build
> From: Len Brown <len.brown@intel.com>
> 
> drivers/ata/libata-acpi.c fails to build
> 
> drivers/built-in.o: In function `ata_acpi_associate':
> (.text+0x7106a): undefined reference to `register_hotplug_dock_device'
> 
> When CONFIG_ATA_ACPI=y and CONFIG_ACPI_DOCK=m
> But if dock is selected from ata_acpi, dock will =y
> when ata_acpi=y, avoiding this problem.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Tejun Heo <htejun@gmail.com>

I think this one will be more straight forward for users.

Thanks.

-- 
tejun
