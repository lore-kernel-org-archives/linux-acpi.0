From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] ACPI / OSL: Improve initrd override mechanism
Date: Fri, 11 Mar 2016 00:44:29 +0100
Message-ID: <1608364.NStxNAounA@vostro.rjw.lan>
References: <cover.1456899242.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52420 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932437AbcCJXmf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:42:35 -0500
In-Reply-To: <cover.1456899242.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, March 02, 2016 02:16:02 PM Lv Zheng wrote:
> This patchset improves initrd override mechanism.
> 
> Lv Zheng (2):
>   ACPI / OSL: Cleanup initrd table override code
>   ACPI / OSL: Add support to install tables via initrd
> 
>  drivers/acpi/internal.h |    1 +
>  drivers/acpi/osl.c      |  158 +++++++++++++++++++++++++++++------------------
>  drivers/acpi/tables.c   |    2 +
>  3 files changed, 101 insertions(+), 60 deletions(-)

Both applied, thanks!

Rafael

