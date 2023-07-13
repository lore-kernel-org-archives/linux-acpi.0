Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759CBC001DE
	for <linux-acpi@archiver.kernel.org>; Thu, 13 Jul 2023 23:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjGMXuY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 13 Jul 2023 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjGMXuX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2023 19:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7B2707
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jul 2023 16:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6560461B8A
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jul 2023 23:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3AF2C433C9;
        Thu, 13 Jul 2023 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689292220;
        bh=106eGJVdrylFUJYLLjs32mAengt7pnJ5aTLxjWXCFfo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BWVBEQ35xeyk6eB3oWhRVdqLvkjuqndjV83IwQ8KJNOc/qKAXFlKhaq+sTVa+g64u
         djzGybh63PLFcxByU/B18AimmiAORR7FGh8C+nyvOjbgzNZ6ofT34vrD/uPrkJZKFA
         +i+XuIidCjMUd64VsJUHILxpuGB7iooedWZzrH1e7W8bwYGkvXZ6e4xm2EHAZWvOR/
         j0+rfUc/hW198gqQLTzHbv+iebRDNoR8VKyye2xk2A7E+go+Nc8e/3C9J+33bHtGu0
         0JYrhq2/MbVCdBFY25SGUfphfKxbEccoQ6wwvGeOAdtaZcPFQhno+Ss/psa/RF4URJ
         jWsPPCUbBGCmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A726EE29F46;
        Thu, 13 Jul 2023 23:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: Don't include Zicsr or Zifencei in I from ACPI
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168929222068.13465.18252134214903655361.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Jul 2023 23:50:20 +0000
References: <20230711224600.10879-1-palmer@rivosinc.com>
In-Reply-To: <20230711224600.10879-1-palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, sunilvl@ventanamicro.com,
        linux-acpi@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 11 Jul 2023 15:46:00 -0700 you wrote:
> ACPI ISA strings are based on a specification after Zicsr and Zifencei
> were split out of I, so we shouldn't be treating them as part of I.  We
> haven't release an ACPI-based kernel yet, so we don't need to worry
> about compatibility with the old ISA strings.
> 
> Fixes: 396c018332a1 ("RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - RISC-V: Don't include Zicsr or Zifencei in I from ACPI
    https://git.kernel.org/riscv/c/ab2dbc7acced

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


