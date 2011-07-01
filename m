From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Fri, 01 Jul 2011 21:34:45 +0200
Message-ID: <4E0E2155.4070508@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:54137 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1GATeu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2011 15:34:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Cc: Mattia Dongili <malattia@linux.it>, Marco Chiappero <marco@absence.it>

Dear all,

(cc:ing Mattia and Marco since they seem to be actively working on
sony-laptop.ko)

I have a Sony Vaio VPCY2 with a backlight control problem -- both with
acpi_backlight=video and acpi_backlight=vendor.

With the former, setting the backlight (with Fn-F5/6) gave the 
appearance, as far as 
/sys/class/backlight/acpi_video0/{actual_,}brightness is concerned, that 
the change took place, however, the screen brightness remained 
unchanged. Even setpci-ing the hardware register does not make a difference.

Kernel bug report here: https://bugzilla.kernel.org/show_bug.cgi?id=38342

Fedora bug report: https://bugzilla.redhat.com/show_bug.cgi?id=689962

Is the Vaio Y's backlight supposed to be controlled by sony-laptop 
instead of by video.ko? Right now with sony-laptop, actual_brightness 
always reads -1 no matter what value is written to brightness.

If there's any information not currently attached to those bug reports 
that is needed, please let me know.

Thanks in advance,

-- 
Michel Alexandre Salim
GPG key ID: 78884778

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
