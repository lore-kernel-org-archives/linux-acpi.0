Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C878C6FD1C
	for <linux-acpi@archiver.kernel.org>; Fri, 24 Mar 2023 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCXPbK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPbK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 11:31:10 -0400
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C81DB8A;
        Fri, 24 Mar 2023 08:31:09 -0700 (PDT)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4Pjm1W0rdlzDVr;
        Fri, 24 Mar 2023 11:13:19 -0400 (EDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Pjm1T0Qq7z457m;
        Fri, 24 Mar 2023 11:13:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1679670797; bh=eXxYmdszhhw0kUjABs9t5ImLtFd713sh9gO3yDRDrXY=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=hfvJObU8vLggyM7vjS1yXskkkhShaVfiz91Vkius6Wd1933tx1EIrQOPwIZ0o9rzg
         AVkyHngloAkLt4EVR1I98YF+QwYLAZeqoYaawznV9UXQSxKsD+sIoW/vNQpobNrLBN
         JiR0m/oclYZuaqCeR6imL5q9dFj6TvoZU5Y3R8O0=
X-Panix-Received: from 166.84.1.3
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Fri, 24 Mar 2023 11:13:17 -0400
Message-ID: <1d7c19066c9b92aaa50bb06cf3ea539d.squirrel@mail.panix.com>
In-Reply-To: <5687037.DvuYhMxLoT@kreacher>
References: <5687037.DvuYhMxLoT@kreacher>
Date:   Fri, 24 Mar 2023 11:13:17 -0400
Subject: Re: [PATCH v1] ACPI: bus: Rework system-level device notification
 handling
From:   "Pierre Asselin" <pa@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Linux ACPI" <linux-acpi@vger.kernel.org>,
        "Pierre Asselin" <pa@panix.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rafael, the patch doesn't apply off of 6.3-rc1.  I have the stable tree,
git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git that goes a little
past 6.3-rc3.  I can try to adjust the offsets, but a better way would be
to add your tree.  Can you give me the appropriate git remote and git pull
incantations ?  I've only been gitting for a month.


