From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Causing an ACPI event from a device driver
Date: Thu, 30 Nov 2006 18:21:53 +0300
Message-ID: <456EF711.8010005@linux.intel.com>
References: <29545330611300524g5e2507f2k5534c1b946b73362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:3873 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030421AbWK3PV6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Nov 2006 10:21:58 -0500
In-Reply-To: <29545330611300524g5e2507f2k5534c1b946b73362@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Benton <benton71@gmail.com>
Cc: linux-acpi@vger.kernel.org

Eric Benton wrote:
> Hi,
>
> Is it possible to generate a GPE from a device driver?
> I mean, if I'm turning on the right bit in the GPE0 status register?
>
> Thanks,
> Eric.
These bits should generally be read-only.

Regards,
    Alex.
