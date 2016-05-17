From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Date: Tue, 17 May 2016 12:48:53 -0400
Message-ID: <b0933a59-239d-536f-4f63-a65e469f62a1@redhat.com>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
 <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbcEQQtA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 May 2016 12:49:00 -0400
In-Reply-To: <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On 05/17/2016 12:44 PM, Jon Masters wrote:

> 1). During development of a platform, it is much easier to debug
> problems with tables if you can test replacement ones without having to
> respin the firmware. In the server world, you usually don't have the
> firmware source code, so to get it respun could be days-weeks even if
> you are working with the authors closely. We have practically used this
> feature on a number of platforms already and it will continue.

For example, on one platform we were unable to fully boot RHEL(SA) due
to a bug in one of the ACPI tables. But I was able to boot the system to
a ramdisk containing a uuencode library and then write out the content
of the tables over the serial port, then decompile/patch/recompile, and
override replacement tables on the system. Then we beat the vendor up
with the fixes and the official firmware was corrected.


-- 
Computer Architect | Sent from my Fedora powered laptop
