Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9EC63697
	for <linux-acpi@archiver.kernel.org>; Wed, 18 Nov 2020 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C27A24199
	for <linux-acpi@archiver.kernel.org>; Wed, 18 Nov 2020 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KVrCPU92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKRMpk (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 18 Nov 2020 07:45:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47560 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKRMpk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Nov 2020 07:45:40 -0500
Received: from zn.tnic (p200300ec2f0caf0066ae0a9db02cf7f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:66ae:a9d:b02c:f7f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 257C01EC01A8;
        Wed, 18 Nov 2020 13:45:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605703539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L2ugBrbTIr2gsU7YZp4QhcDMy178gRinJLza+UP4oi8=;
        b=KVrCPU9214MZUDQ7mAZakHuHmWrFsC3ceX4DfPxeRysevGHqu1ZuYPv5xExJJaMWl5hElw
        HhFZ4gxnH2lnN8TiWXI3mRelHwmWsJ97eXrOdUnMArU3geMe/81Yd7Ki/KAwWcMk2axHb/
        G91cVHfaGQWl8ZG5uCmJ0exbXLaBzNI=
Date:   Wed, 18 Nov 2020 13:45:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, yangfeng1@kingsoft.com,
        CHENGUOMIN@kingsoft.com
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201118124538.GI7472@zn.tnic>
References: <20201104065057.40442-1-yaoaili126@163.com>
 <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 17, 2020 at 05:58:04PM +0800, Aili Yao wrote:
> Subject: [PATCH v2] Dump cper error table in mce_panic
> 
> For X86_MCE, When BIOS option WHEA memory log is enabled,if there is a
> ...

This commit message makes no sense to me and I have no clue what you're
trying to "fix". So before you do anything, please describe the problem
you're seeing first using this structure:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

When you do that, use simple english sentences and not complex ones.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
