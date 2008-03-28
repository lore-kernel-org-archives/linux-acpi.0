From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 15:09:22 -0700
Message-ID: <200803281509.23107.david-b@pacbell.net>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281409.09622.david-b@pacbell.net> <924EFEDD5F540B4284297C4DC59F3DEEC83E08@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:32608 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757548AbYC1WJZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 18:09:25 -0400
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEEC83E08@orsmsx423.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday 28 March 2008, Pallipadi, Venkatesh wrote:
> You should have a dmesg line which looks like
> ACPI: CPU0 (power states: C1[C1] C2[C2]
> Do you see C2 in such line?

Yes:

ACPI: CPU0 (power states: C1[C1] C2[C2])



