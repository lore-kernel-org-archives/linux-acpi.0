From: Lourival Neto <lourival.neto@gmail.com>
Subject: how to get acpi info inside the kernel?
Date: Sun, 1 Mar 2009 22:41:48 -0300
Message-ID: <4a33b1190903011741l3698db9cg70bf9bf2108fc868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:46310 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241AbZCBBlv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Mar 2009 20:41:51 -0500
Received: by fxm24 with SMTP id 24so1790975fxm.37
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2009 17:41:48 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, folks.

I'm writing a cpufreq governor and I want to use some acpi info, like
temperature, to make decisions. Is there a way to get this info inside
the kernel without use sysfs? Where can I find linux-acpi interface
documentation?

Thank you in advance,
--
Lourival Vieira Neto
