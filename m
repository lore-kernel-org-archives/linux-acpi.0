From: Phillip Susi <psusi@cfl.rr.com>
Subject: Automatic S1 sleep
Date: Tue, 11 May 2010 12:03:21 -0400
Message-ID: <4BE97FC9.4040302@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-2.exch016.msoutlookonline.net ([207.5.72.164]:1216
	"EHLO EXHUB016-2.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab0EKQNa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 12:13:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have been looking into the possibility of having the system
automatically enter and exit S1 to save power when idle, but actively in
use.  For instance, while you are only browsing the web on your laptop,
your eyes spend 15 seconds scanning the page while the system is
otherwise, doing nothing but wait for your next input.  It would be nice
if it could seamlessly enter S1 during this time to save power, and exit
when you press a key, move the mouse, or receive a message on IRC.

Unlike S3, S1 keeps the Vcc power plane on and all devices remain in D0
or D1, so the screen remains on and visible, so it should be possible to
use this state transparently without the user even being aware of it.
Since everything remains on, no hardware needs reinitialized when
resuming from S1.  Here seems to be a problem with the current kernel code:

It seems that the generic pm core code defined the PM_EVENT_SUSPEND
state with S3 in mind, and so hardware drivers are notified of
PM_EVENT_SUSPEND and reinitialized when resuming, assuming that the
hardware lost power.  When using acpi S1, this reinitialization activity
is not required and should not be done, so it seems that S1 should not
generate PM_EVENT_SUSPEND and PM_EVENT_RESUME events.

Does anyone have any thoughts on my conclusion or advice on how to
trigger S1 without generating PM_EVENT_SUSPEND?
