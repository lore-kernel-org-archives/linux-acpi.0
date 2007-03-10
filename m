From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: [PATCH 11/22] ACPI: EC: Don't use Global Lock if not asked to do so
Date: Sat, 10 Mar 2007 14:12:05 +0000
Message-ID: <E1HQ2In-0001fp-00@skye.ra.phy.cam.ac.uk>
References: <11734992704035-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:62822 "EHLO
	mraos.ra.phy.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161062AbXCJOqB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Mar 2007 09:46:01 -0500
In-Reply-To: Your message of "Fri, 09 Mar 2007 23:00:48 EST."
             <11734992704035-git-send-email-lenb@kernel.org> <705ff592931e6738926fd6d596461010a1e8977d.1173498654.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

Does this patch obsolete the patch to "release global lock in
acpi_ec_wait"?  It's part of bugzilla 6749 "Thinkpad A21m freeze after
second supedn to RAM"
<http://bugzilla.kernel.org/show_bug.cgi?id=6749> and its direct url
is <http://bugzilla.kernel.org/attachment.cgi?id=8481&action=view>.

Or did that patch get integrated via some other flow of code?  It
fixed the S3 suspend hangs on my TP 600X.  It might also help the T60:
Once in a long while it would hang on suspend and it reminded me of
the 600X's behavior (though the T60 has an ancient kernel, 2.6.17-10
from ubuntu, which is why I never filed a report).  I work around the
problem by unloading the fan and thermal modules before suspending.
It also hangs once in a while on resume, but those problems will
hopefully be resolved by a more recent kernel.

-Sanjoy

`Not all those who wander are lost.' (J.R.R. Tolkien)
