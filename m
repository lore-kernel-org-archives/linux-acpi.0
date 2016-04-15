From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
Date: Fri, 15 Apr 2016 09:42:49 +0100
Message-ID: <20160415084249.GI15182@e104818-lin.cambridge.arm.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47789 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbcDOImy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Apr 2016 04:42:54 -0400
Content-Disposition: inline
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2016 at 08:53:41AM +0100, Mark Brown wrote:
> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
