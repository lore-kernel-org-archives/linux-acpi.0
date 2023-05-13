Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB4C7EE23
	for <linux-acpi@archiver.kernel.org>; Sat, 13 May 2023 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjEMKvE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 13 May 2023 06:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEMKvD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2023 06:51:03 -0400
Received: from tilde.cafe (tilde.cafe [51.222.161.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3814735A7;
        Sat, 13 May 2023 03:51:01 -0700 (PDT)
Received: from localhost (94.250.94.80.dyn.idknet.com [80.94.250.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tilde.cafe (Postfix) with ESMTPSA id 1BF3F20251;
        Sat, 13 May 2023 06:50:56 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 13 May 2023 13:50:55 +0300
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Cc:     <stable@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   "Acid Bong" <acidbong@tilde.cafe>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        <regressions@lists.linux.dev>
Message-Id: <CSL3BO4G05T7.TXT503TF8XQC@bong>
X-Mailer: aerc 0.14.0-126-g6d59ad3f02bc
References: <CRVU11I7JJWF.367PSO4YAQQEI@bong>
 <5f445dab-a152-bcaa-4462-1665998c3e2e@gmail.com>
 <ZE+1pKbfy1l/tTo6@debian.me>
In-Reply-To: <ZE+1pKbfy1l/tTo6@debian.me>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi there, hello. A little mid-update.

I bisected almost all range after 6.1.3 and the only untested commits
left are unrelated to my hardware (AMD-specific stuff). I spent a week
with a 6.1.1 kernel and didn't experience a single hang since, which
leads me to a couple of conclusions:

1) it's not a hardware issue after all, since certain versions don't
produce the bug
2) (this one's more an assumption) I might've got the version range
wrong.

I'm gonna try 6.1.2 and 6.1.3 as well (up to 7 more days for each), and,
depending on the output, bisect in a different range (now I regret not
doing it in the beginning).

At the moment the earliest *tested* commit is:
```
[15e7433e1dc202] arm64: dts: qcom: sc8280xp: fix UFS DMA coherency.
```
and it's marked as "bad".

Thank you for your patience.
