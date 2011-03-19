From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Status of native backlight patchset?
Date: Sat, 19 Mar 2011 14:17:16 +0100
Message-ID: <4D84ACDC.7010904@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59886 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1CSNRW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Mar 2011 09:17:22 -0400
Received: by fxm17 with SMTP id 17so4418954fxm.19
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2011 06:17:21 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

Hi,

Is there an updated version of the native backlight patchset that 
Matthew posted in November?

http://thread.gmane.org/gmane.linux.acpi.devel/48145

On my Sony Vaio Y, Intel Ironlake/Arrandale integrated graphics, I'm 
having problems setting my backlight level through 
/sys/class/backlight/acpi_video0 -- all inputs seem to be ignored:

https://bugs.freedesktop.org/show_bug.cgi?id=34417

and it looks like the same issue that is being tracked by Ubuntu's Kamal 
Mostafa, based on Matthew's patchset:

https://launchpad.net/~kamalmostafa/+archive/linux-kamal-mjgbacklight

I've not been able to find a patchset newer than the one from November,
and if I apply patches 1 & 2 (skipping 3 & 4 because they don't apply to 
i915), I get a kernel with broken KMS. Should I apply #5 as well? I'll 
wait to see if there's a newer patchset before trying that, though.

Matthew, do you have a public kernel git tree I can clone from?

Thanks,

-- 
Michel Alexandre Salim

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
