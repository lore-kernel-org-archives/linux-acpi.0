From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup device coherency
Date: Wed, 29 Apr 2015 18:15:40 +0200
Message-ID: <2718230.tGqneBjFr2@wuerfel>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com> <5540FB2D.4080905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60301 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbbD2QQQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2015 12:16:16 -0400
In-Reply-To: <5540FB2D.4080905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Al Stone <al.stone@linaro.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wednesday 29 April 2015 09:39:25 Al Stone wrote:
> 
> When the spec was being changed for _CCA, it was determined by the ASWG
> that there was no reasonable default -- either choice would break something.
> Multiple OSs, SoC vendors, and platform vendors were asked.  So, the spec
> says for ARMv8, _CCA must be specified when needed and is not assumed to have
> any value.  Obviously, any OS can choose to behave differently, but that's
> what was specified and why it was specified that way.

Ok, so it was essentially a CYA strategy. As we know that for Linux we're
only interested in server parts here, but we also want to be compliant,
I'd still argue that we check the property value and just disallow DMA
for any device that is lacking CCA or contains zero here.

The current patch actually implements non-standard behavior: if _CCA
is missing, it registers the device as dma-capable with coherency turned
off, where my interpretation of the cited standard would be that we
treat a missing _CCA as not being able to perform DMA. What I'd like
to see instead is to only enable DMA support if _CCA is present and
enabled.

	Arnd
