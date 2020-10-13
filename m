Return-Path: <SRS0=FYmK=DU=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF9C433E7
	for <linux-acpi@archiver.kernel.org>; Tue, 13 Oct 2020 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA242536E
	for <linux-acpi@archiver.kernel.org>; Tue, 13 Oct 2020 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602610525;
	bh=o9oltwg1i9VLLLsNVeZQ+tfdL972Fo9SrKCe6V2OkfQ=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=CKuy6R+c7SaciG2d254DcDkb7EXqadfbFqfVDjcXypXBbs/ZGNA4L3CZGBwkbLDDT
	 EXsM6slJ/fTbM1d5JqHOlNBzQW0RVDK8EyxkVcFATkDGUyA7eUz9g6AQOcI/9Ndpbl
	 wOqpRuwkmJd+n5wZcIaEhhEg/yEaE+WOSVdwwLuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgJMRfY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:35:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46613 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMRfY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2020 13:35:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id s81so180759oie.13;
        Tue, 13 Oct 2020 10:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=j90o4pXE8wrwI/DObfaFUgJw3Uhg+maJFJpVAo6JkBA=;
        b=Vby9lid004lre9qOCw/oQBsvuz+9bEM+lZmwV1Ud8DJpY0IcureVG6TsMUE6eqBxiA
         OKQflSM67Tr4YQpH5B+OheweQ4frkwr/xJQSw/0nJioVOqC28d3aO+O7Xaw94TKqWvok
         UeH6bEB+y/ppI169xiqOBDvrf3RJQj6siq7y0wygkImtrTqgiakz+PGqmlRRQki+qmBW
         i5SKbDKhStQ4iwW5YWqzBaz8dHK/ujBUEJbRD+qhVheEp0mBHRa7+sa2+iyqhQS4cTkl
         f7BLw4ZSXVIdLag2VSSJu1m4zNWqDwfskOwqQoeC7pQbvL7MG+AsZaF2iVuBT01FOSV6
         RnOQ==
X-Gm-Message-State: AOAM530wWDf0PLs8xEZ4o9210ffN7vic/bl+6C7oLvBnZUS55XMSGChS
        eCVwioqS1h1Hxq93fZ5sKs2vmJ0Ww1B0FUKw9cGZhbAYiF0=
X-Google-Smtp-Source: ABdhPJxrrZw26n5N1rCRo0ZhIngERFyu8lKE5hsJrarcEs2ViOUUgl+S4SniHKVKTkL0Sjj+1KaaSQVj6024aQwHvao=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr513288oii.69.1602610523613;
 Tue, 13 Oct 2020 10:35:23 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Oct 2020 19:35:12 +0200
Message-ID: <CAJZ5v0gj1X7kO2uVX=zMzR6+y1BWAERT+HDT+0zY0ieXs+Lx3g@mail.gmail.com>
Subject: [GIT PULL] PNP updates for v5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-5.10-rc1

with top-most commit 2ef0342530b0f487a65b5f6c94c85dce5f9b53b5

 PNP: remove the now unused pnp_find_card() function

on top of commit ba4f184e126b751d1bffad5897f263108befc780

 Linux 5.9-rc6

to receive PNP updates for 5.10-rc1.

These clean the PNP code somewhat:

 - Remove the now unused pnp_find_card() function (Christoph Hellwig).

 - Drop duplicate pci.h include from the quirks code and add an
   "internal.h" include to acpi_pnp.c to fix a compiler warning (Tian
   Tao).

Thanks!


---------------

Christoph Hellwig (1):
      PNP: remove the now unused pnp_find_card() function

Tian Tao (2):
      PNP: quirks: Fix duplicate included pci.h
      PNP: ACPI: Fix missing-prototypes in acpi_pnp.c

---------------

 Documentation/admin-guide/pnp.rst |  4 ----
 drivers/acpi/acpi_pnp.c           |  2 ++
 drivers/pnp/isapnp/compat.c       | 23 -----------------------
 drivers/pnp/quirks.c              |  2 --
 include/linux/isapnp.h            |  6 ------
 5 files changed, 2 insertions(+), 35 deletions(-)
