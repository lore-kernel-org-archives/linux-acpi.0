Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A1EEB64DD
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Aug 2023 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjHHCkr (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Aug 2023 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHHCkq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 22:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6E10D2
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 19:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678A362324
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3344C433CA;
        Tue,  8 Aug 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691462421;
        bh=xKOlSGJHH9pDn+O9oivNc+VjOK0cMPfD2BollqSq4Fw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q/1OfgqMBDmpZmtVuuBL96TFd4roSmxBFKCsszfwoT40QhFNMDWlz8IlmzDCzElDk
         kyyjZcej6MuXJpRurqZR7iaT+2JZ6IVmhMcSx7LJwcWZGUzX8zzmOLQXkJ4ImCMcH/
         qSdTql7wtYvx6KZ29FGc9EmTlEjJb99xNesLz8K7iktcJeEyM4m7v+7ltmn3eJ0jpX
         3Yb9B/eUSa/f+Jb5xxQxGirByHhvrWnDob0xG9Zsp0ZkpSufuuVoU66Q8EECtyzK7G
         qD/b5B5FyF0EWX/wogAr0mSRemT3HYBlu3rwuY41aQ24KzW10jh1J0n7+RquE6eMd8
         y+2MFob0NKzfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A77E0E505D5;
        Tue,  8 Aug 2023 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] platform/chrome: chromeos_acpi: support official HID
 GOOG0016
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169146242168.22152.1080564918581930878.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 02:40:21 +0000
References: <20230731024214.908235-1-tzungbi@kernel.org>
In-Reply-To: <20230731024214.908235-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, rafael@kernel.org,
        lenb@kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        usama.anjum@collabora.com, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 31 Jul 2023 10:42:14 +0800 you wrote:
> Support official HID GOOG0016 for ChromeOS ACPI (see [1]).
> 
> [1]: https://crrev.com/c/2266713
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v2[2]:
> - Instead of replacing, appending "GOOG0016" in sysfs-driver-chromeos-acpi.
> 
> [...]

Here is the summary with links:
  - [v3] platform/chrome: chromeos_acpi: support official HID GOOG0016
    https://git.kernel.org/chrome-platform/c/703e77134ebf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


