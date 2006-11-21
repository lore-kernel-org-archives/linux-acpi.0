From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Please push d4a82b0b566fc2784648c9751f0deb2b262c95ea to Linus for 2.6.19
Date: Tue, 21 Nov 2006 17:52:50 -0200
Message-ID: <20061121195249.GG29510@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51394 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1031357AbWKUTwy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 14:52:54 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net

Len,

Commit d4a82b0b566fc2784648c9751f0deb2b262c95ea:
ACPI: ibm_acpi: allow clean removal

Allow clean removal by setting notify_installed in the right place.

Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

Which is currently on acpi-test, should IMHO be pushed to Linus for 2.6.19
and maybe even submitted to stable@vger.kernel.org for 2.6.18.y.

Do you agree?  Can you push it to Linus if so?

I have a report that the lack of this commit causes rmmod ibm-acpi on a A21m
to consistently crash and burn if the kernel was compiled with ibm-acpi dock
support.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
