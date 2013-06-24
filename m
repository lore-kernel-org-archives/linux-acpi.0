From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] ACPI: Documentation udpates
Date: Mon, 24 Jun 2013 14:02:44 +0200
Message-ID: <2648916.FgKhqXliA2@vostro.rjw.lan>
References: <1364824711-5193-1-git-send-email-rui.zhang@intel.com> <cover.1371619148.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48993 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3FXLxR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jun 2013 07:53:17 -0400
In-Reply-To: <cover.1371619148.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Thursday, June 20, 2013 08:01:39 AM Lv Zheng wrote:
> This patch set adds 2 ACPI documentation files with MAINTAINERS updated.
> 
> Lv Zheng (3):
>   ACPI: Update MAINTAINERS file to include Documentation/acpi
>   ACPI: Add sysfs ABI documentation
>   ACPI: Add ACPI namespace documentation
> 
>  Documentation/ABI/testing/sysfs-bus-acpi    |   58 ++++
>  Documentation/ABI/testing/sysfs-devices-sun |    2 +-
>  Documentation/acpi/namespace.txt            |  395 +++++++++++++++++++++++++++
>  MAINTAINERS                                 |    2 +
>  4 files changed, 456 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-acpi
>  create mode 100644 Documentation/acpi/namespace.txt

All queued up for 3.11.

Thanks,
Rafael


