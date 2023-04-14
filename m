Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071FC77B73
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Apr 2023 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDNSva convert rfc822-to-8bit (ORCPT
        <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNSv3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2023 14:51:29 -0400
Received: from tilde.cafe (tilde.cafe [51.222.161.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBCB65A8;
        Fri, 14 Apr 2023 11:51:27 -0700 (PDT)
Received: from localhost (124.250.94.80.dyn.idknet.com [80.94.250.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tilde.cafe (Postfix) with ESMTPSA id 6AA1B20703;
        Fri, 14 Apr 2023 14:51:25 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 14 Apr 2023 21:51:23 +0300
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Cc:     <linux-acpi@vger.kernel.org>, <regressions@lists.linux.dev>,
        <stable@vger.kernel.org>
From:   "Acid Bong" <acidbong@tilde.cafe>
To:     <acidbong@tilde.cafe>
Message-Id: <CRWPAKIQL542.31GZ9N30HQV3V@bong>
In-Reply-To: <CRWCUOAB4JKZ.3EKQN1TFFMVQL@bong>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For the readers: here's a copy of the letter as it should've looked (it
looks normally in the regressions archive, but wasn't parsed correctly
in stable and linux-acpi lores):
https://tilde.cafe/u/acidbong/kernel/pci-nomsi.txt
