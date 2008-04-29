From: Len Brown <lenb@kernel.org>
Subject: ACPI video patches for 2.6.26
Date: Tue, 29 Apr 2008 11:14:20 -0400
Message-ID: <1209482064-25440-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6427 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755376AbYD2PO1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 11:14:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Here are some cleanups to the video driver
for 2.6.26.

The head of Dmitry's patch series made it into 2.6.24, but
these didn't make it at the time, which IIR was post -rc1.
I don't recall why I didn't revive them for 2.6.25 --
maybe I was waiting for Rui or Dmitry to refresh them...

Anyway, here they are, refreshed to 2.6.26-rc0,
along with a minor cleanup from Thomas's new video series.

I'll reply to this message with the final cleanup
from Dmitry's series.  It needs to be refreshed.
It is also large enough that I think if I did it now
that could be a pain for Thomas who is currently hacking
on this code.  (Though Thomas, if you refresh it and
send it to me, I'll take that to mean that it is
okay with you -- hint, hint;-).

thanks
-Len


