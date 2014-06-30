From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 05/13] ARM64 / ACPI: Introduce arm-core.c and its
 related head file
Date: Mon, 30 Jun 2014 17:24:06 +0100
Message-ID: <20140630162406.GR28951@arm.com>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-6-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:56632 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754944AbaF3QY2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jun 2014 12:24:28 -0400
Content-Disposition: inline
In-Reply-To: <1403840976-7456-6-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, "rric@kernel.org" <rric@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Fri, Jun 27, 2014 at 04:49:28AM +0100, Hanjun Guo wrote:
>  drivers/acpi/Makefile          |    2 +
>  drivers/acpi/plat/Makefile     |    1 +
>  drivers/acpi/plat/arm-core.c   |  110 ++++++++++++++++++++++++++++++++++++++++

Do you ever plan to add ACPI support for 32-bit ARM? If not, this part
could be placed under arch/arm64 (similar to x86).

-- 
Catalin
