Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E179C77B72
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Apr 2023 07:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDQHjV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDQHi7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2023 03:38:59 -0400
Received: from tilde.cafe (tilde.cafe [51.222.161.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C35B82;
        Mon, 17 Apr 2023 00:38:14 -0700 (PDT)
Received: from localhost (124.250.94.80.dyn.idknet.com [80.94.250.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tilde.cafe (Postfix) with ESMTPSA id 12717204E8;
        Mon, 17 Apr 2023 03:37:49 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Apr 2023 10:37:49 +0300
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Cc:     <acidbong@tilde.cafe>, <bagasdotme@gmail.com>,
        <linux-acpi@vger.kernel.org>, <regressions@lists.linux.dev>,
        <stable@vger.kernel.org>
From:   "Acid Bong" <acidbong@tilde.cafe>
To:     <regressions@leemhuis.info>
Message-Id: <CRYTB8JBZ2LK.BAFK0AHDHPNA@bong>
In-Reply-To: <b2edf1ed-2777-03ef-4d5e-e355a6074f78@leemhuis.info>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

So, I followed your advice and used the sources (6.3-rc6). Compiled even
two versions: with my config (cf. head letter) and the Arch Linux one
(I'm using Gentoo, but it still fits well), both updated with
`olddefconfig`. Just to make sure that the problem is independent from
the config.

Good news: I experienced the hanging 3 times with both kernels
yesterday.

Two of them were on the custom kernel, and they were of the rare kind -
they occured on shutdown. It goes normally, init disables the services,
unmounts the filesystems, turns off the screen, but then - no response
and the LED and the fan are still on. Another couple of shutdowns went
normal, so the issue it still irregular.

One happened later on the Arch-based one and after a suspend.

/var/log/kern.log showed nothing specific in all cases.

Bad news: it seems, the fix hasn't arrived yet.

How do I proceed next?

--

P.S. On the `pci=nomsi` case: I don't consider it being related to the
issue we're discussing. For me it seems like a hardware issue that can
be bypassed by reconfiguration.
