From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mailbox: add ACPI support for mailbox framework
Date: Tue, 7 Apr 2015 17:05:05 +0300
Message-ID: <20150407140505.GB1734@lahna.fi.intel.com>
References: <1427836680-13008-1-git-send-email-fkan@apm.com>
 <CAL85gmA1mjcX6FEmUHipn0iSzpti2z6D4++7Q3gxGiPGZaE_Cw@mail.gmail.com>
 <20150407084143.GP17830@lahna.fi.intel.com>
 <11619620.g1RKbURH6u@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbbDGOHT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Apr 2015 10:07:19 -0400
Content-Disposition: inline
In-Reply-To: <11619620.g1RKbURH6u@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Feng Kan <fkan@apm.com>, patches <patches@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Apr 07, 2015 at 01:37:56PM +0200, Rafael J. Wysocki wrote:
> To be precise, PRP0001 specifically means "Use the 'compatible' property
> to find the driver for this device", so if *that* is what you want to do,
> you can use PRP0001 as the _HID.  For Windows (and such) compatibility, you
> can provide a _CID whith a (list of) proper device ID(s) in addition to that.

Thanks for clarification Rafael :-)
