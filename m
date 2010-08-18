From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: [REGRESSION] [SUSPEND] Opps during suspend to disk (probably also during to ram)
Date: Wed, 18 Aug 2010 21:02:02 +0200
Message-ID: <201008182102.03201.maciej.rutecki@gmail.com>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38978 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0HRTCH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Aug 2010 15:02:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Last known good kernel: 2.6.35
Failing kernel: 2.6.36-rc1

When I try suspend to disk under 2.6.36-rc1 ("no_console_suspend" option 
enabled) system hangs on this message:
http://unixy.pl/maciek/download/kernel/2.6.36-
rc1/zlom/suspend_issue/dsc_0001.jpg

Also during suspend to ram system hangs, but I got blank screen, so - 
unfortunately - I cannot debug this.

Config:
http://unixy.pl/maciek/download/kernel/2.6.36-
rc1/zlom/suspend_issue/config-2.6.36-rc1
dmesg:
http://unixy.pl/maciek/download/kernel/2.6.36-
rc1/zlom/suspend_issue/dmesg-2.6.36-rc1.txt
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
