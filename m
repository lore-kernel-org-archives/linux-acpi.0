From: Ferenc Wagner <wferi@niif.hu>
Subject: battery: current a factor of 10 off?
Date: Fri, 21 Nov 2008 01:33:39 +0100
Message-ID: <87skplx6ho.fsf@szonett.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:48259 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbYKUAds (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Nov 2008 19:33:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: wferi@niif.hu

Hi,

on my ThinkPad R50e the current_now reading seems something like 10
times the actual value.  Documentation/power/power_supply_class.txt
says it's in uA, and a tipical discharge value is around 15259000,
that is, 15 A on my system.  At the same time voltage is 11756000,
that is, 12 V, which sounds reasonable, but then the power is 15*12 VA,
ie 180 W, which is insane.  However, the numerical derivative of
energy_now gives 18 W, which is both reasonable and consistent with
the assumed factor of 10 error in current_now.  Is this possibly a bug
in 2.6.26.6?  During a quick glance over battery.c nothing obvious
jumped at me, but I'm no expert on this.
-- 
Thanks,
Feri.
