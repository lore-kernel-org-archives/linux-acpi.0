From: Olivier Diotte <olivier@diotte.ca>
Subject: Board hangs without acpi=off
Date: Tue, 26 Mar 2013 11:09:55 -0400
Message-ID: <CAM3Q4oGq+nLYPR68NnA_mTTLvrmRzxWNbRpQ_zjq6VO5_hUp-Q@mail.gmail.com>
Reply-To: olivier@diotte.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:34836 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759806Ab3CZPJ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Mar 2013 11:09:58 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so13531379lab.7
        for <linux-acpi@vger.kernel.org>; Tue, 26 Mar 2013 08:09:56 -0700 (PDT)
Received: by mail-la0-f52.google.com with SMTP id fs12so13541918lab.25
        for <linux-acpi@vger.kernel.org>; Tue, 26 Mar 2013 08:09:55 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a development board here that hangs when trying to boot linux
(actually Ubuntu Precise Pangolin's kernel 3.5.7.6).
Supplying the kernel parameter 'acpi=off' allows the board to boot
correctly. The problem is that we need this board to boot with a
working ACPI stack.

I recompiled Ubuntu's kernel adding support for ACPI debugging
(CONFIG_PM_DEBUG=y, CONFIG_ACPI_DEBUG=y) and did some tests with
'acpi.debug_layer' and 'acpi.debug_level' and can provide these if
needed, though I am unsure if this is the right approach.

Is there something I can do to get this board's ACPI working? Any hint
and/or approach would be a good step forward.

Regards,
Olivier
