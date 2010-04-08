From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / EC / PM: Fix race between EC transactions and suspend/hibernate process
Date: Fri, 9 Apr 2010 01:38:13 +0200
Message-ID: <201004090138.13522.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41594 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349Ab0DHXir (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Apr 2010 19:38:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

Hi Len,

The following two patches fix BKO #14668.  The first one is the actual fix
and the other one changes the names of the involved functions so that they
better reflect what's done.

Please apply.

Rafael

