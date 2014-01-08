From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 5/6] power: reset: change xgene reboot driver to use both acpi and dts resource for reboot.
Date: Wed, 8 Jan 2014 22:43:01 +0100
Message-ID: <201401082243.01694.arnd@arndb.de>
References: <1389135041-16062-1-git-send-email-fkan@apm.com> <1389135041-16062-6-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64911 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbaAHVnc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jan 2014 16:43:32 -0500
In-Reply-To: <1389135041-16062-6-git-send-email-fkan@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Feng Kan <fkan@apm.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 07 January 2014, Feng Kan wrote:
> Enable the X-Gene reboot driver to use either the ACPI or the DTS
> resource using the platform driver method.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/power/reset/xgene-reboot.c |   33 ++++++++++++++++++++++++++++-----
>  1 files changed, 28 insertions(+), 5 deletions(-)
> 

Shouldn't an ACPI based system always be able to reboot through the
UEFI reset_system call? I really don't think we want to support
ACPI on non-UEFI systems.

	Arnd
