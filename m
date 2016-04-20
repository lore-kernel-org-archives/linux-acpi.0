From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/3] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Wed, 20 Apr 2016 11:30:12 -0500
Message-ID: <CAOZdJXWzqwZMHV0Qu4FE=j+N3oP3XrDN-+AqUhG61wxFdC945w@mail.gmail.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
	<1460706823-16566-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60434 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTQaP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Apr 2016 12:30:15 -0400
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com [209.85.213.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: timur@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 3871260F71
	for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2016 16:30:13 +0000 (UTC)
Received: by mail-ig0-f174.google.com with SMTP id g8so54293483igr.0
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2016 09:30:13 -0700 (PDT)
In-Reply-To: <1460706823-16566-2-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, arm@kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 15, 2016 at 2:53 AM, Mark Brown <broonie@kernel.org> wrote:
>
> Given all this it seems that at this point the EXPERT dependency mainly
> creates inconvenience for users with systems that are doing the right
> thing and gets in the way of including the ACPI code in the testing that
> people are doing on mainline.  Removing it should help our ongoing
> testing cover those platforms with only ACPI support and help ensure
> that when ACPI code is merged any problems it causes for other users are
> more easily discovered.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Acked-by: Graeme Gregory <graeme.gregory@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Al Stone <ahs3@redhat.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
