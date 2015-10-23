From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] GHES: Fix cached error-status
Date: Fri, 23 Oct 2015 23:05:15 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F32B5DE60@ORSMSX114.amr.corp.intel.com>
References: <20151019175554.GB3367@linux-uzut.site>
 <20151023225057.GF27292@linux-uzut.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5525 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbbJWXFR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2015 19:05:17 -0400
In-Reply-To: <20151023225057.GF27292@linux-uzut.site>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Davidlohr Bueso <dave@stgolabs.net>, "Huang, Ying" <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> ping?

I'm not actually sure that the code is wrong.  As you say it is a pretty strange loop.

We seem to want to look at a bunch of conditions, and use "continue" to ignore
bits until we find one that we like the look of.  Perhaps as soon as we do, we want
to believe it to get our return value? Perhaps the code knows that we won't find
another section that matches all the tests, so it isn't worth going around the loop
again.

Ying: You wrote this code 4 years ago. Any recollections of why it looks like it does?

-Tony
