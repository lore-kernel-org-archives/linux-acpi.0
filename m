From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/5] acpi: battery: Split battery driver for reuse by
 DPTF power participant
Date: Fri, 1 Jul 2016 00:08:06 +0200
Message-ID: <CAJZ5v0geNqtMi99JE4NTVByxUB-JECKPpVGRnO8=YKQMZCAoGA@mail.gmail.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1467244819-19046-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35187 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcF3WIV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 18:08:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id v199so4252010wmv.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2016 15:08:08 -0700 (PDT)
In-Reply-To: <1467244819-19046-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jun 30, 2016 at 2:00 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> DPTF power participant device have common objects with ACPI battery device
> "PNP0C0A". For example the main battery objects:
> _BST: returns dynamic battery information
> _BIX: The static battery properties and control method
> Also both can register with power_supply class to present properties
> of a typical battery device.
>
> To avoid code duplication, the existing battery driver is split into two
> parts:
> - A common part
> - ACPI battery driver
>
> battery_common
> Most of the existing battery driver source, except ACPI enumeration part
> moved a separate file. It exposes an interface, which can be used by ACPI
> battery driver and DPTF power participant driver.
> Also the current battery driver code had lots of check_patch errors.
> These check_patch errors are addressed in this battery_common. These are
> the main interface functions:
> acpi_battery_common_add
> acpi_battery_common_remove
> acpi_battery_common_resume
> acpi_battery_common_notify
>
> battery: This is ACPI battery driver, which just enumerate on PNP0C0A
> device and use interface functions offered by battery common part.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Are there any functional changes in this patch?
