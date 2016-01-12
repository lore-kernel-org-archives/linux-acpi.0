From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 1/2] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Tue, 12 Jan 2016 18:59:36 +0000
Message-ID: <56954D18.1010306@arm.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com> <1446857519-5908-2-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36562 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbcALS7l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jan 2016 13:59:41 -0500
In-Reply-To: <1446857519-5908-2-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Loc Ho <lho@apm.com>, dougthompson@xmission.com, bp@alien8.de, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: jcm@redhat.com, patches@apm.com, linux-acpi@vger.kernel.org, Tuan Phan <tphan@apm.com>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org

On 07/11/15 00:51, Loc Ho wrote:
> The function acpi_gsi_to_irq should returns 0 on success as upper function
> caller expect an 0 for sucesss.

I have to ask: why do you feel the need to change an API that behaves
like the rest of the IRQ allocation functions (at least when it comes to
its return value)?

0 is defined as an invalid interrupt, and I wish it stayed that way.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
