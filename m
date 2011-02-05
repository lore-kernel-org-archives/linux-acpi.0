From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/8] ACPI / PM: Use existing ACPI iomaps for NVS save/restore (v2)
Date: Sat, 5 Feb 2011 19:20:19 +0100
Message-ID: <201102051920.20195.rjw@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101250032.07423.rjw@sisk.pl> <AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46751 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab1BESUa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Feb 2011 13:20:30 -0500
In-Reply-To: <AANLkTi=nAhadVy6y6f4uOy0-pvTQrdwYgQ0y_4ukui2z@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Saturday, February 05, 2011, Jeff Chua wrote:
> The suspend monster is back! The suspend-to-ram is fine, but upon
> resume, screen is blank. Haven't bisected in case someone has also
> done so.
> 
> It's very recent. ... between commit
> 831d52bc153971b70e64eccfbed2b232394f22f8 and
> 44f2c5c841da1b1e0864d768197ab1497b5c2cc1.

No idea.  I bet on DRI.

Thanks,
Rafael
