Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98A3C433EF
	for <linux-acpi@archiver.kernel.org>; Fri,  3 Jun 2022 10:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiFCKCM (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiFCKCL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jun 2022 06:02:11 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973845FA2
        for <linux-acpi@vger.kernel.org>; Fri,  3 Jun 2022 03:02:08 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id c1-20020a928e01000000b002d1b20aa761so5410535ild.6
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jun 2022 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CETyWVHu7ACjpSUlEO+0eiI0hfJXIrRX6DzyX/3YTu4=;
        b=jntsUHt+LA5KNETF0hzk/nCf9s4rlWfFd7pnBLS8VeGjzzFbDCijwXXiOuhVrfCCDO
         WmM4+Pesq5DJqeJ0Livx/DVrwr5Jvgk3QQO0FoFPjeGAyI/2VYCBnXWmlLdC5IBIPDO4
         mZ283quDYi9+T3zCeqI+mJT0cEQbi5TmKjv0aWKTxuIc9WZ9qKCWAZO7TKlThEejS6ma
         I7UfWvhxyFfr+ubYkAANeTuvWVUOOGMEJR49QMLblt0yvSoTtvmCh9rgmgJ0ZUtQmzya
         QqUSrX3NND0pCkHO5mfBLhO7xt3W1kEgHCEX6sy5AF4i5NSsVYCfXAv9BjeTvetB6CVt
         otJA==
X-Gm-Message-State: AOAM530mDu7pejGn+rGcQUbxwZykJ1ljoqNzXLkunX/GYpSsQ6FiY+0I
        lFN5lo+ywMqph0trQWHrAkmpank9uyfW0IAFVlOjdgWgJXeT
X-Google-Smtp-Source: ABdhPJzbSJVbRANJ4lX5DaQExVRaf/aESQ7vPiixhdBT1+wC8VMM8xNu/cX8tmXqyxgNCDxCmiEyLOkFSxd21nQbl7YGufSdIA/D
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d01:b0:330:cdea:7084 with SMTP id
 q1-20020a0566380d0100b00330cdea7084mr5405003jaj.117.1654250527568; Fri, 03
 Jun 2022 03:02:07 -0700 (PDT)
Date:   Fri, 03 Jun 2022 03:02:07 -0700
In-Reply-To: <000000000000bb7f1c05da29b601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010b7d305e08837c8@google.com>
Subject: Re: [syzbot] general protection fault in __device_attach
From:   syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

syzbot has bisected this issue to:

commit a9c4cf299f5f79d5016c8a9646fa1fc49381a8c1
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Jun 18 13:41:27 2021 +0000

    ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1040b80df00000
start commit:   d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1240b80df00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1440b80df00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15613e2bf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c90adbf00000

Reported-by: syzbot+dd3c97de244683533381@syzkaller.appspotmail.com
Fixes: a9c4cf299f5f ("ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
