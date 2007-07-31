From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: regression on HP zx1 platform from ACPI autoload modulespatches
Date: Tue, 31 Jul 2007 09:54:05 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A020E3B4F@scsmsx411.amr.corp.intel.com>
References: <1185900042.18821.213.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29404 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758817AbXGaQyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2007 12:54:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1185900042.18821.213.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Doug Chapman <doug.chapman@hp.com>, Tony Luck <tony.luck@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

> Tony, it looks like the patch has not hit Linus tree yet:


Huh?  I can see it in his tree via gitweb.  Here's the patch:

	http://tinyurl.com/3csnu6

and the raw "blob" for sba_iommu.c:

	http://tinyurl.com/397cy6

[Scroll down to line 2018 and you'll see the new code in place].

Something very odd is happening.

-Tony
