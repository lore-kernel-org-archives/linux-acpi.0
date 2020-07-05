Return-Path: <SRS0=oUqN=AQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BD3C433E0
	for <linux-acpi@archiver.kernel.org>; Sun,  5 Jul 2020 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6BD2073E
	for <linux-acpi@archiver.kernel.org>; Sun,  5 Jul 2020 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="h7J6MyUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGEL1p (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 5 Jul 2020 07:27:45 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:56748 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgGEL1p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jul 2020 07:27:45 -0400
Date:   Sun, 05 Jul 2020 11:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1593948027;
        bh=ludDIecIecLRERf3nK6GDknuNZGkNiPAOtJ+rBhWNR8=;
        h=Date:To:From:Reply-To:Subject:From;
        b=h7J6MyUySr0jZ9mV9cgtVFTp1fsYlXXBKmz5Ol7FbyKrgij47f2rCV0YfMaiu2wz+
         0k+7W0D+GmKqf6qhzcX6pta/Bi/pCWEPIXZwiCxR3e1EzLX0XumPkxlpppbykZRCxU
         3KgExgYnxGkHEe4HBO6Zn3+oCd1W3xUKweowIhtA=
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [QUESTION] multiple EC transactions atomically
Message-ID: <9ILq1c0IEdOEJutX0acOTF19CCrqrvtwzfbFNAhQ7k2jWX4eNcmW8b82OgLBdrj44kTxRz0_GYKTbYyGGYwNMI2QVjwGgBcSjHSDl2Qc13A=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all,

I am looking for a way, preferably with the acpi/ec driver, to execute mult=
iple EC transactions atomically (with respect to other transactions). Unfor=
tunately, I have failed to find any promising functions in that driver. Ple=
ase let me know if I have missed anything.

The reason I would like to do it is that I have a computer in which the EC =
appears to have paged memory, and a series of commands must be executed to =
read/write data in arbitrary pages, and I would like to guarantee that they=
 are executed as one atomic block.

If there is no facility that would allow it to be done, then am I right in =
assuming that making drivers/acpi/ec.c:acpi_ec_transaction accept multiple =
transactions, that it then executes sequentially while holding the mutex, s=
hould achieve the goal without much difficulty? I think that could work, ho=
wever, I am not really familiar with ACPI or the EC driver.

I would greatly appreciate any help, feedback. Thank your for your time.


Barnab=C3=A1s P=C5=91cze

