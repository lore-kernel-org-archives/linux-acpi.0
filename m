From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] ACPI / scan: Make it clear that acpi_bus_trim() cannot fail
Date: Thu, 24 Jan 2013 16:12:47 -0800
Message-ID: <CAE9FiQUq8Mr_2RkPec-f9XHxVFMgwHCq9i8jrrUj9GpbC36qew@mail.gmail.com>
References: <1511096.zmfmBrfdmu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:45886 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab3AYAMs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2013 19:12:48 -0500
In-Reply-To: <1511096.zmfmBrfdmu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>, Jiang Liu <liuj97@gmail.com>

On Thu, Jan 24, 2013 at 2:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since acpi_bus_trim() cannot fail, change its definition to a void
> function, so that its callers don't check the return value in vain
> and update the callers.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Yinghai Lu <yinghai@kernel.org>
