From: Len Brown <lenb@kernel.org>
Subject: (STA.functional && !STA.present)
Date: Fri, 9 Mar 2007 00:49:19 -0500
Message-ID: <200703090049.19356.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34332 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992985AbXCIFuy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 00:50:54 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, castet.matthieu@free.fr
Cc: linux-acpi@vger.kernel.org

Matthieu,
what good things happen if instead of using bjorn's current
tweak to simply set STA.present we use your patch here
http://bugzilla.kernel.org/show_bug.cgi?id=3358
which doesn't re-write the bits?

Bjorn, will the case that provoked your change still work?

it is interesting now to google for:
"functional but not present; setting present"
it comes up on more than Tiger systems...

thanks,
-Len
