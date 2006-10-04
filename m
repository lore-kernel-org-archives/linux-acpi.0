From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: T60 ACPI events on 78b656b8
Date: Wed, 4 Oct 2006 23:53:53 +0200
Message-ID: <20061004215352.GG9723@mellanox.co.il>
References: <20060830144646.GC1923@elf.ucw.cz>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dev.mellanox.co.il ([194.90.237.44]:62615 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1751175AbWJDVwe
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Oct 2006 17:52:34 -0400
Content-Disposition: inline
In-Reply-To: <20060830144646.GC1923@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, Borislav Deianov <borislav@users.sourceforge.net>

Just tested the latest Linux git, and I see a weird issue:
after some use, my T60 stops triggering any ACPI events:
tail -f /var/log/acpid
does not show anything, even on Fn/F4 which is supposed ot be always enabled.
Restarting the acpid doesn't do anything either - ACPI starts working
again, for a while, only after reboot.

This worked fine in 2.6.18 - any ideas? How to debug this?

-- 
MST
