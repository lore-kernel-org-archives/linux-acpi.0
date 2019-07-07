Return-Path: <SRS0=Y2+7=VE=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F12C48BDE
	for <linux-acpi@archiver.kernel.org>; Sun,  7 Jul 2019 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4716920830
	for <linux-acpi@archiver.kernel.org>; Sun,  7 Jul 2019 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=markspace.org.uk header.i=@markspace.org.uk header.b="Ig0m0pu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfGGQdm (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 7 Jul 2019 12:33:42 -0400
Received: from us2-ob1-2.mailhostbox.com ([162.210.70.53]:37045 "EHLO
        us2-ob1-2.mailhostbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGGQdm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jul 2019 12:33:42 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2019 12:33:41 EDT
Received: from BLACK1 (unknown [217.155.202.85])
        (Authenticated sender: mark@markspace.org.uk)
        by us2.outbound.mailhostbox.com (Postfix) with ESMTPA id 4101E184105
        for <linux-acpi@vger.kernel.org>; Sun,  7 Jul 2019 16:28:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=markspace.org.uk;
        s=20150511; t=1562516881;
        bh=PObKqU1xVY2TBQucgwO8+v5X6xkYqi2hSsE3zIgQa2o=;
        h=From:To:Subject:Date:Reply-To;
        b=Ig0m0pu86YlrJV1qReGmtTNbPvLvjTJBaYxfVO+OfRvzgXJqnvQ1dVZZt7ITJccWh
         EIEevaNyDjVh9G0G0ot84IvXpC3O7YYcAmXh2VXh0o/CglAPQj67sHMZQ+8QsAYpDE
         dTQXGJmlDylwcI1/cVRsAhG1iN4VFB3qLlCrFSoE=
From:   Mark de Roussier <mark@markspace.org.uk>
To:     linux-acpi@vger.kernel.org
Subject: Kernel panic and ACPI errors with recent update to 4.15.53 ( Ubuntu 18.04 LTS distro )
Date:   Sun, 07 Jul 2019 17:27:47 +0100
Organization: None
Reply-To: mark@markspace.org.uk
Message-ID: <ks54ieh5iu58i8ig1ear1tp2ev4n57r4u4@markspace.org.uk>
X-Mailer: Forte Agent 6.00/32.1186
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.2 cv=f6I4PK6M c=1 sm=1 tr=0
        a=kem1eB1AM3JN/ezlmQFJjg==:117 a=kem1eB1AM3JN/ezlmQFJjg==:17
        a=kj9zAlcOel0A:10 a=r8_XyoLLUObWz1bBGw8A:9 a=CjuIK1q_8ugA:10
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi folk,=20

I'm running a HP Z800 dual processor workstation which has just stopped
being able to boot properly due to a recent update. The machine has the
latest BIOS available from HP ( this was not changed by the update ). The
problem appears to relate to ACPI, and I've been referred here from a =
post
I made to StackExchange.=20

Attempting to boot the machine using any of the available 4.15 kernels (
4.15.43, 4.15.45, 4.15.47, 4.15.53 ) now gives the following ACPI errors =
:

---
ACPI Error: [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS
(20170831/dsfield-212)
ACPI Error: Method parse/execution failed \_SB.PCIO._OSC, =
AE_ALREADY_EXISTS
(20170831/psparse-550)
---

I usually end up dumped into what I believe is an 'emergency shell'.=20

I have tried a large number of acpi related kernel switches, including
'acpi=3Dht' and 'acpi_serialize'. The only thing which appears to affect
behaviour is 'acpi=3Doff'. This causes a kernel panic, in which case I am=
 not
given an emergency shell. I don't know how to grab that info to post here
except for taking a screenshot, and not all the info is actually on the
screen.

So if anyone can suggest a way to further this investigation, I'd be very
grateful. What information would be useful to know, and are there any
particular experiments I should try, anyone else it would be useful to =
talk
to ?

Thanks,
Mark de Roussier
