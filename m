Return-Path: <SRS0=P5bh=SM=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D34CC10F11
	for <linux-acpi@archiver.kernel.org>; Wed, 10 Apr 2019 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1657420830
	for <linux-acpi@archiver.kernel.org>; Wed, 10 Apr 2019 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899976;
	bh=4z9BMQwyNOkQc7aeGBCPckxyxAkAN4jp89R1A0fFtr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yHnjANlZHHLII5Ur2gENpS1Ev7Os4oHOwkMj+kl+glgvNSaCBb0KlCwWqcLI7xTxZ
	 /c2KPr4LiaC5TeUOub/7L2hvzO/G5+pzTSxfF2fd2dPCUvlXTocTryBZhcP3p3gSN8
	 j/I4sna3+0U1GxRpr947G+ksfjSi7SPi9HDau86Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfDJMjf (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:39:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33505 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfDJMjf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Apr 2019 08:39:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id j10so1775921otq.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Apr 2019 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88ju+THJ8XpgIO6stJX85NL9IPuaNhnSo9Pc/ukdfe0=;
        b=I7iWvpycFHOHqDEe3cRAz0Q+DDpfuZwUL7va2mlopCAIw8yvJ5rdDH03kZwq1Yn++T
         8PBJicdRvolifs3CQv7lJ6ueMcdELHTIL4D6W6CUYjfpTLySKPOHREdJOOrH91BzymFK
         y76TbSONuK2KPKmeKtw8CBMlF0UZDAF4EUyyNOzpkhYL6ARYPLItPOBCUMc57+ZsTX/t
         SilIM7hHrw9tjmu95NA98SpRPig8DYOTkSTdLatgA1PTEQX7VzdOTAYcCt9Lm+htAyj7
         575bYux6gUEuxSwkJ8yVIRruID7ikFsSHiw4aRzA8/GgJEZ5ILVU39eCU/hNexd6PYAw
         K+gA==
X-Gm-Message-State: APjAAAVIZG/bnNHIPETOxo+b4CRs7lDCLLcXm4wbipUQa5nClicJAeMp
        /oFEVJ5p2nxRvojgPR4IsqK8UZnDjj0lgoKkfZQ=
X-Google-Smtp-Source: APXvYqwVpJTgqDp0YdRxsByXPvMZGN0P24I/kBXtR1+m5t8NXLFloTmt8sPZwPUTzxiSqh7IEtnryMhXQk36G+Iv8xM=
X-Received: by 2002:a9d:5c09:: with SMTP id o9mr28401693otk.311.1554899974421;
 Wed, 10 Apr 2019 05:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190408204230.4335-1-erik.schmauss@intel.com>
In-Reply-To: <20190408204230.4335-1-erik.schmauss@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Apr 2019 14:39:22 +0200
Message-ID: <CAJZ5v0j_-qLRQV8SR-zs8WHYoyZO=vmwQrsmaiN5vfxKLiTxuw@mail.gmail.com>
Subject: Re: [PATCH 0/8] ACPICA release 20190329 and 20190405
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 8, 2019 at 10:52 PM Erik Schmauss <erik.schmauss@intel.com> wrote:
>
> Since ACPICA had a release within one week of each other, this patch-set
> contains both releases. Notable items include a patch to remove a
> namespace node from the global address list correctly. Other than that,
> there are several renamings for clarity.
>
> This patch-set is also available at the link below:
> https://github.com/SchmErik/linux/commits/acpica201904
>
> Bob Moore (5):
>   ACPICA: Rename nameseg copy macro for clarity
>   ACPICA: Rename nameseg compare macro for clarity
>   ACPICA: Rename nameseg length macro/define for clarity
>   ACPICA: Update version to 20190329
>   ACPICA: Update version to 20190405
>
> Erik Schmauss (3):
>   ACPICA: Namespace: remove address node from global list after method
>     termination

All applied, I put this one on the fast track for 5.1-rc5.

>   ACPICA: utilities: fix spelling of PCC to platform_comm_channel
>   ACPICA: Namespace: add check to avoid null pointer dereference

Thanks!
