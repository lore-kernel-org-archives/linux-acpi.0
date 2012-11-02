From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 0/2] ACPI: CPU hot-remove support
Date: Fri, 02 Nov 2012 13:46:01 +0100
Message-ID: <1678274.pulvZO82Js@vostro.rjw.lan>
References: <1351780933-30560-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52122 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab2KBMlz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2012 08:41:55 -0400
In-Reply-To: <1351780933-30560-1-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com, prarit@redhat.com, bhelgaas@google.com

On Thursday, November 01, 2012 08:42:11 AM Toshi Kani wrote:
> This patchset adds support of CPU hot-remove via an ACPI eject
> notification to the ACPI processor driver.  The CPU hot-remove
> operation shares the same code path with the sysfs eject operation.
> 
> The patchset also exports two functions necessary to initiate
> hot-remove operations from modules, such as the processor driver.
> 
> The patchset is based on the current Linus's tree.
> 
> v3:
> - Added patch 1/2 to export functions for hot-remove
> 
> v2:
> - Rebased to the latest baseline
> 
> ---
> Toshi Kani (2):
>  ACPI: Export functions for hot-remove
>  ACPI: Add ACPI CPU hot-remove support

Both patches applied to the linux-next branch of the linux-pm.git
tree as v3.8 material.

Thanks,
Rafael


> ---
>  drivers/acpi/osl.c              |  1 +
>  drivers/acpi/processor_driver.c | 27 +++++++++++++++++----------
>  drivers/acpi/scan.c             |  1 +
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
