From: Michel Lespinasse <walken@zoy.org>
Subject: Suspend issue on Intel DG965RY system
Date: Mon, 21 Apr 2008 03:38:03 -0700
Message-ID: <20080421103803.GE20322@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:59857 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479AbYDUKiE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 06:38:04 -0400
Received: from michel.lespinasse.org (michel.home.lespinasse.org [10.1.0.1])
	by server.lespinasse.org (Postfix) with ESMTP id 7484E2FB9B
	for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2008 03:38:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

I'm having a minor issue with suspend-to-ram on an Intel DG965RY system.
I'm using a 2.6.25 kernel. The system does suspend and resume correctly,
but sometimes (roughly 40% of the time I'd estimate) it suspends again
just after the resume succeeds.

The obvious workaround I've been using is to keep pressing the power button
as many times as needed for the machine to stay on...

I did notice that when the system suspends multiple times, the value in
/sys/firmware/acpi/interrupts/ff_pwr_btn increments by that many times.

I do run acpid, and my powerbtn.sh script includes the following:
/etc/init.d/apcupsd stop
/etc/init.d/ntp     stop
sync
echo mem > /sys/power/state
/etc/init.d/ntp     start
sleep 5
/etc/init.d/apcupsd start
/etc/init.d/anacron start

I see there was a thread "Machine shutdown after resume from S3" back in
february, this sounds somewhat similar to my problem. I have not tried
removing the button module around a suspend - I actually don't have it
built as a module right now, is there any other way to temporarily
deactivate the button module ?

Thanks for any advice,

-- 
Michel Lespinasse
