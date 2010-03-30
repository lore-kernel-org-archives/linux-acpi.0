From: Philippe De Muyter <phdm@macqel.be>
Subject: how to diagnose/fix : cannot boot without acpi=off
Date: Tue, 30 Mar 2010 22:55:16 +0200
Message-ID: <20100330205516.GC26538@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:28727 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752051Ab0C3UzU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Mar 2010 16:55:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 2001D158AC8
	for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2010 22:55:18 +0200 (CEST)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hgVaxubSSjGJ for <linux-acpi@vger.kernel.org>;
	Tue, 30 Mar 2010 22:55:16 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 96FF0158AC3
	for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2010 22:55:16 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello acpi experts

I have just installed opensuse 11.3 milestone 4 (2.6.33-6-desktop) on a laptop
hp pavilion dv6-1300sb, and it refuses to boot without acpi=off which in turn
prevents me to use the wireless chip.

I would like to diagnose precisely what the problem(s) is/are.

which option should I add to the linux commandline to make it point to the
problem ?  I have already tried 'ignore_loglevel debug' but the last
message is never the same.

Philippe
