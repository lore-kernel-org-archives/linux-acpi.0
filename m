From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: [2.6.33{rc2-git1,2}]: hp-wmi again broken
Date: Thu, 31 Dec 2009 17:17:43 +0100
Message-ID: <2d0a357f0912310817p3b828239qc81994973fca1274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:63349 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZLaQRp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Dec 2009 11:17:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: Anisse Astier <anisse@astier.eu>, len.brown@intel.com

Hi,

I am not sure why this bug has re-entered from linux-acpi-2.6 to
linux-kernel, but I just wanted to report Anisse has re-send a fix for
hp-wmi [1].
The original bug was reported with appended patch in [2].
>From 2.6.33-rc2 to 2.6.32-git2 hp-wmi is still broken.
Please, fix that cleanly in upstream, now.
Thanks.

Kind Regards,
- Sedat -

[1] ACPI & driver patches for 2.6.33-rc2
http://patchwork.kernel.org/patch/70398/
[2] [2.6.33-rc2] ACPI problems on HP nc6400 notebook
http://patchwork.kernel.org/patch/69745/
