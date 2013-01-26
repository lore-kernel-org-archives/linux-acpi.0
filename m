From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Problems with gpe13 interrupt storm.
Date: Sat, 26 Jan 2013 09:46:24 +0000
Message-ID: <CAAMvbhFRvNpJ3h138grZugAH+Lb74+DSSD4sg0RxADOXvVHEcA@mail.gmail.com>
References: <CAAMvbhGcEPgfGFQt-Y1T+OzG9=Moa97W-XL8+qnW7sOWVqfCDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:55894 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab3AZJqZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Jan 2013 04:46:25 -0500
Received: by mail-ee0-f49.google.com with SMTP id d4so549287eek.22
        for <linux-acpi@vger.kernel.org>; Sat, 26 Jan 2013 01:46:24 -0800 (PST)
In-Reply-To: <CAAMvbhGcEPgfGFQt-Y1T+OzG9=Moa97W-XL8+qnW7sOWVqfCDw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Some more detailed context can be found here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/887793

    Scope (_GPE)
    {
        Method (_L13, 0, NotSerialized)
        {
            If (LEqual (PFLV, FDTP))
            {
                Return (Zero)
            }

            Store (Zero, GPE3)
            Or (GL08, 0x10, GL08)
            Notify (\_SB.PCI0.SAT0, 0x82)
            Return (Zero)
        }
    }

This is the DSDT code for GPE13 on a Samsung Series 7 700Z5C laptop.
There error reported by the Linux kernel is:
 ev_queue_notify_reques: No notify handler for Notify, ignoring (SAT0, 82)

Now, my question is:
How do I find out what device is causing the GPE13 interrupt and why?
How do I work out what code (which device register bit to reset) I have to
put in this Notify handler in order to silence the interrupt storm?

Kind Regards

James
