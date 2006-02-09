From: Joseph Pingenot <trelane@digitasaru.net>
Subject: Working around buggy DSDT's
Date: Thu, 9 Feb 2006 08:29:56 -0600
Message-ID: <20060209142956.GE25770@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:18701 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S932515AbWBIO35 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2006 09:29:57 -0500
Received: from cruftix.physics.uiowa.edu ([128.255.70.79] helo=cruftix)
	by kludge.physics.uiowa.edu with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <trelane@digitasaru.net>)
	id 1F7Co1-00020Z-Cd
	for linux-acpi@vger.kernel.org; Thu, 09 Feb 2006 08:29:57 -0600
Received: from solarion by cruftix with local (Exim 4.54)
	id 1F7Co0-00009a-I7
	for linux-acpi@vger.kernel.org; Thu, 09 Feb 2006 08:29:56 -0600
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello.

I recall reading that the buggy DSDT's are caused by Microsoft's compiler,
  since Microsoft's ACPI implementation isn't fazed by the bugs in its
  output.
Is this true and, if so (or not), is it possible to work around the buggy
  DSDT's without resorting to initrds to replace the DSDT?  How does Windows
  work with the buggy DSDTs out there?
Thanks!

-Joseph
-- 
trelane@digitasaru.net--------------------------------------------------
          Graduate student in physics, Free Software developer.
