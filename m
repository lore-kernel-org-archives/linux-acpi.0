From: Daniel Drake <dsd@gentoo.org>
Subject: Laptop screen doesn't come on when lid is reopened
Date: Sun, 06 May 2007 16:17:50 -0400
Message-ID: <463E37EE.2060008@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp165.iad.emailsrvr.com ([207.97.245.165]:47319 "EHLO
	smtp165.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbXEFUnN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 May 2007 16:43:13 -0400
Received: from [192.168.1.102] (c-24-34-179-5.hsd1.ma.comcast.net [24.34.179.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ddrake@brontes3d.com)
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 7F27B67BD38
	for <linux-acpi@vger.kernel.org>; Sun,  6 May 2007 16:18:39 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Like many Dell's, my Inspiron 640m turns off the LCD display when the 
lid is closed, but doesn't power it back up when the lid is opened.

This has been discussed before, with the conclusion that it's a BIOS bug 
which Linux can't fix (i.e. including a link in the kernel from ACPI to 
video isn't practical). However I'd like to revisit this as I believe 
I've found some information which wasn't discussed/observed before:

The lid notification method can be seen here: 
http://bugzilla.kernel.org/show_bug.cgi?id=5155#c6

Of specific interest, the lid notification comes with video 
notifications - the DSDT seems to be expecting the OS to do something 
with the video hardware.

I dug further and found that the first Store in that method is what 
turns the display off, and the following If always triggers (for both 
open and close events) in my testing. Sidenote: this means that the DSDT 
turns the display off both on close and on open.

I also found that no link to the video layer of the kernel would be 
needed to restore the display here: the _DSS method of the LCD device 
will happily turn the display back on.

I fixed my DSDT with this modification:

      Method (LIDE, 0, NotSerialized)
      {
+        // If lid open, enable video
+        If (LNotEqual(\_SB.LID._LID(), 0)) {
+            \_SB.PCI0.VID.LCD._DSS(0x80000001)
+            Notify (\_SB.LID, 0x80)
+            Return
+        }
+
+        // If lid closed, continue
+
+        // The following Store turns the LCD off
          Store (SMI (0x43, 0x00), Local0)
          If (LAnd (LNotEqual (Local0, 0x00), LNotEqual (Local0, 0x0F)))

Works nicely, woohoo!

I'd now like to investigate moving this modification into the kernel so 
that no DSDT changes are required. I'm running into some problems here:

If I create an acpi_driver alongside the button driver, the button 
driver claims the lid and my driver doesn't. I presume this is by design 
-- I was hoping that he subsystem would allow 2 drivers to work on the 
same device.

I then tried creating a new module which would use acpi_get_handle() to 
find the lid handle, and then acpi_install_notify_handler() to set up an 
event handler. I was hoping that the subsystem would allow multiple 
handlers on one event, but it appears I'm out of luck again: While the 
button driver is loaded and subscribed to this event, my driver gets the 
AE_ALREADY_EXISTS error code.

Are there other approaches I can take here? I'm hoping to create some 
kind of "Dell extras" driver, which contains a list of buggy systems, 
and listens for the lid events. When it detects a lid open event, it 
will call _DSS on the LCD device.

Thanks,
Daniel
