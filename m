From: Damien Wyart <damien.wyart@free.fr>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 17:05:00 +0200
Message-ID: <20070925150500.GA2632@localhost.localdomain>
References: <20070925065109.GA3080@localhost.localdomain> <20070925092755.GA4553@localhost.localdomain> <20070925095855.GA4982@localhost.localdomain> <200709251345.11370.rjw@sisk.pl> <20070925120202.GA5641@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-dmz-232-tuesday.dmz.nerim.net ([195.5.254.232]:56005 "EHLO
	kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751416AbXIYPHD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2007 11:07:03 -0400
Content-Disposition: inline
In-Reply-To: <20070925120202.GA5641@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Torsten Kaiser <just.for.lkml@googlemail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, linux-acpi@vger.kernel.org

> Will test this evening the patch you pointed in your next message.

Ok, with both patches (including the very latest one from Alexey ---
tried the "stylistically correct" one), machine halts fine again. Thanks
to all for having looked at this!

-- 
Damien Wyart
