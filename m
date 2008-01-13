From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9721] New: wake on lan fails with sky2 module
Date: Sun, 13 Jan 2008 22:27:58 +0100
Message-ID: <200801132227.59229.rjw@sisk.pl>
References: <bug-9721-10286@http.bugzilla.kernel.org/> <478A743C.9050405@yahoo.de> <20080113125708.070b4843.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38221 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbYAMVZH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jan 2008 16:25:07 -0500
In-Reply-To: <20080113125708.070b4843.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: supersud501 <supersud501@yahoo.de>, Stephen Hemminger <shemminger@linux-foundation.org>, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

I wonder if commit 84cd2dfb04d23a961c5f537baa243fa54d0987ac
"sky2: remove check for PCI wakeup setting from BIOS" has anything to do with
it, btw.

supersud501, can you please check if the bug is still present in the current
Linus' tree?
