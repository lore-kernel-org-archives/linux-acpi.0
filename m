From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH 0/7] fujitsu-laptop: ACPI-related cleanups
Date: Fri, 16 Jun 2017 06:40:51 +0200
Message-ID: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36109 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPElL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2017 00:41:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so2754800wme.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jun 2017 21:41:10 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation for splitting fujitsu-laptop into two separate modules, I
prepared two more cleanup series to minimize the amount of code being
moved around.  This first series contains all patches that touch ACPI in
some way, which is why I am CCing linux-acpi as per Rafael's previous
advice.

This patch series was based on platform-driver-x86/for-next and tested
on a Lifebook S7020.

 drivers/platform/x86/Kconfig          |  10 --
 drivers/platform/x86/fujitsu-laptop.c | 187 +++++++++-------------------------
 2 files changed, 48 insertions(+), 149 deletions(-)

-- 
2.13.1

