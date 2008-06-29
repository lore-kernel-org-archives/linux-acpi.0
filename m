From: garkein@mailueberfall.de
Subject: Processor state C6 only used in battery mode, workaround possible?
Date: Sun, 29 Jun 2008 12:12:33 +0200
Message-ID: <1214734353.5024.19.camel@thinkpad>
Reply-To: garkein@mailueberfall.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753357AbYF2KNE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Jun 2008 06:13:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,
with recent powertop, I could confirm that my T61 uses the C6 processor
state only in battery mode:

(Kernel 2.6.25)

AC:
Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6 
Your BIOS reports the following C-states : C1 C2 C3

Battery:
Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6 
Your BIOS reports the following C-states : C1 C2 C6

Since the notebook runs quite a bit cooler, and thus less noisy (fan) in
battery mode, I would like to have it use that C6 state also in AC mode.
Is it possible, maybe with some slight tweaks, to convice the kernel (or
BIOS?) to also use that C6 state when in AC mode?

Thanks,
Daniel


