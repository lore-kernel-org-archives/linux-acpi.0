From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] arm64: defconfig: Enable ACPI
Date: Fri, 15 Apr 2016 09:42:26 +0100
Message-ID: <20160415084226.GH15182@e104818-lin.cambridge.arm.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
 <1460706823-16566-3-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47784 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbcDOImb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Apr 2016 04:42:31 -0400
Content-Disposition: inline
In-Reply-To: <1460706823-16566-3-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2016 at 08:53:43AM +0100, Mark Brown wrote:
> Enable ACPI by default to support testing of ACPI only systems and
> ensure that defconfig will boot on anything, for arm64 this is not done
> in Kconfig since a very large proportion of arm64 systems have no ACPI
> at all.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
