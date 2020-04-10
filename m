Return-Path: <SRS0=MBWV=52=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4756C2BA2B
	for <linux-acpi@archiver.kernel.org>; Fri, 10 Apr 2020 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790652064A
	for <linux-acpi@archiver.kernel.org>; Fri, 10 Apr 2020 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586512236;
	bh=sVia3h1J5BVTwBD5wUHMu5JMExT9vcMP0nqMLBYktMM=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=P3ej1fJ37eGZcFywNyODYWeELN+f5wUvXUSaaPLBCNl8dzJN8CXrN++yiNArTb/VZ
	 I+slsMmeYLzJkIe2VvElA7b+giY4zP/A1Fzs7BFJ9ZURiD6jgQTf+Yv0ZIdkV8I4J7
	 lQeD3GyDkgtQIoock9nDophXdckbuONwqIiKvB+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJJuf (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:50:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39431 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJJuf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2020 05:50:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id x11so1378115otp.6;
        Fri, 10 Apr 2020 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iKhNpJ8qVUg8Zg4eX9pSmK83aKuUthTOf/oQ+sa/l9s=;
        b=INaZ6hIaY1oo82GPRBMJjJzgx6wwMs7LMKfo2LdWxyXha6wf4SsxYoWruCsiJKRXTS
         ODOoFkWyeOVHrqV4QHvRZJXxojC38zgAuA+RVdaeOdT5OGqioQ4ZCPd17+cG8Mfg8yNf
         qy3FMeHBZxwPOetZRYVmWYtvStCshQAe9CvIk3GzSA2FVKz9w1I/bTO7R4iDgohegZCH
         xP0dG7MbfgUBchbQ29tNX4Cim9AeEH9jqW0myv7zWyAukaA4OalQ+Bvzmcmy7J2Uzqn/
         o9zvwXa9Dos2h84bcV6K8kqZNNmeBRhzQ2/K069uNppMSsSJTd5jtT2DBCKPXxstRyhw
         Au2A==
X-Gm-Message-State: AGi0PuYp7exynjQT49m6Ttuo7P1MCEibTEMBNhGdykm93zPgqF+j+uSD
        EObT6j85KwGPS1eKsIas+Zt9ho/mq6xZvBpBjcJgrFgA
X-Google-Smtp-Source: APiQypI4bz4JGebBrEGirLeUCog/uYr7XTIy5rZ1b7RYA62xYEBQDmE3SiekjjXTXbuf1nqo/ICZxZwxwoJGGFdb4OI=
X-Received: by 2002:a9d:7402:: with SMTP id n2mr3597051otk.262.1586512234925;
 Fri, 10 Apr 2020 02:50:34 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Apr 2020 11:50:23 +0200
Message-ID: <CAJZ5v0g8hyYjx1eTZ7U+zvE+UrPjseZSAd-r6=-G4U_2M05yEA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.7-rc1-3

with top-most commit 0214da7cce2030f1a71fb555e2967faf3b92aebf

 Merge branches 'acpi-ec' and 'acpi-x86'

on top of commit 7e63420847ae5f1036e4f7c42f0b3282e73efbc2

 Merge tag 'acpi-5.7-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.7-rc1.

These prevent a false-positive static checker warning from triggering
in the ACPI EC driver (Rafael Wysocki), fix white space in an ACPI
document (Vilhelm Prytz) and add static annotation to one variable
(Jason Yan).

Thanks!


---------------

Jason Yan (1):
      ACPI, x86/boot: make acpi_nobgrt static

Rafael J. Wysocki (1):
      ACPI: EC: Fix up fast path check in acpi_ec_add()

Vilhelm Prytz (1):
      Documentation: firmware-guide: ACPI: fix table alignment in namespace.rst

---------------

 Documentation/firmware-guide/acpi/namespace.rst | 6 +++---
 arch/x86/kernel/acpi/boot.c                     | 2 +-
 drivers/acpi/ec.c                               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
