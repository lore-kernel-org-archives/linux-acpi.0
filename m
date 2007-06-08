From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Docking support?
Date: Fri, 8 Jun 2007 18:47:06 +0800
Message-ID: <20070608104706.GA10553@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:36261 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935189AbXFHKrQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 06:47:16 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kristen.c.accardi@intel.com, linux-acpi@vger.kernel.org

Hi,

The dock driver seems to work for me for undocking: when I press the
button on my docking station, kernel prints a message and the button
turns blank, telling me that I can get my laptop out.

However, when I put my laptop back on the docking station, nothing seems
to happen.  Do I need to echo something on /proc or something else?
Also, I'd really like to receive ACPI docking events in userland for
triggering video devices configuration for instance.

Samuel
