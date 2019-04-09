Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DFC10F0E
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3826E2084F
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554802196;
	bh=RpGGC4pPiZL70XWICHT3+mwhuIXybJiNJzyBNBhbNqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KR7POqMb7eJff5/0L2qCHraWf0iGP4086nTdz2yDNGjOku366CQFspyBkOwVQzqYW
	 ozOuvgi3r3fI81i/TszA6+nhaJNsXNK9mIUQ6J6ohnhg5Nb/dWAGnauFPj4ls+4NAD
	 Zx1PPS/FvUCh3byq/61reL8iOuionObkHFWVUaCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfDIJ3y (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:29:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36924 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDIJ3y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Apr 2019 05:29:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so12975439oif.4
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2019 02:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpGGC4pPiZL70XWICHT3+mwhuIXybJiNJzyBNBhbNqs=;
        b=cLFMKIjhpKH5zPIVV6sT0BdFj1crf8sQ7eJ1PudfwwKMyD6myPSfx0m1di0MQRpkeE
         mOrzPZeYEsZvRzR4nXTar1W049gmk+n0teWKuBEBqttFo9CqjnpE4dhq2prRrapt+ip/
         csqQ6Axr4ygX54kcJJr1hRFNg+SE4T4LJ8tPW1Be5mcWTiysvxTbkdW/LgkpB4tY0Fhv
         fygsEkK1T3cywiDhkXX904Wy6sQndXqTCCK2PG8FLV65nDRBrXEUZw1+ymyFevAMUg91
         jIpmpEUFexqiQWWerlt7zRlYl/0lfnSE+QNgSlTZB26bakfdyKkn1/oGIeL8kSyfY6bw
         yvBw==
X-Gm-Message-State: APjAAAXbrXhekXBFlVYh50UNrX+cQgIqO+zEyVmy/70gMEGpa/WjBpwM
        q8olh63lcHi2EKeLnS6vk8+EQyc8p/UodD5Uk2O3yuVt
X-Google-Smtp-Source: APXvYqzCTBToqok/ki3PxaRG9gxo4Tp5hPErkyw189S+35tqiFrAriNRoevsFiV0ni5qU4wgetp1zqjv+UD1/aGN3oo=
X-Received: by 2002:aca:eb93:: with SMTP id j141mr18634164oih.178.1554802193934;
 Tue, 09 Apr 2019 02:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190408204230.4335-1-erik.schmauss@intel.com> <20190408204230.4335-4-erik.schmauss@intel.com>
In-Reply-To: <20190408204230.4335-4-erik.schmauss@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 11:29:42 +0200
Message-ID: <CAJZ5v0j1ondAX_jK==YaoPdejDeinb7cirBR2W6H89uAx7crMA@mail.gmail.com>
Subject: Re: [PATCH 3/8] ACPICA: Rename nameseg length macro/define for clarity
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 8, 2019 at 10:52 PM Erik Schmauss <erik.schmauss@intel.com> wrote:
>
> From: Bob Moore <robert.moore@intel.com>
>
> ACPICA commit 24870bd9e73d71e2a1ff0a1e94519f8f8409e57d
>
> ACPI_NAME_SIZE changed to ACPI_NAMESEG_SIZE
> This clarifies that this is the length of an individual
> nameseg, not the length of a generic namestring/namepath.
> Improves understanding of the code.
>
> Link: https://github.com/acpica/acpica/commit/24870bd9
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>

This missed some Linux-specific files referring to ACPI_NAME_SIZE, but
I fixed it up.
