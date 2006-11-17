From: David Brownell <david-b@pacbell.net>
Subject: Re: [Bulk] Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Fri, 17 Nov 2006 13:45:28 -0800
Message-ID: <200611171345.29216.david-b@pacbell.net>
References: <200611142303.47325.david-b@pacbell.net> <200611160853.48748.david-b@pacbell.net> <455CDE75.3050001@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:40829 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753224AbWKQVpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Nov 2006 16:45:34 -0500
In-Reply-To: <455CDE75.3050001@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday 16 November 2006 1:56 pm, Alexey Starikovskiy wrote:
> David,
> 
> It looks like problem with recent changes to EC driver, so could you 
> please try to revert those patches one-by-one in order to
> find problematic one... I'm attaching patches: ec_x1 is the first in 
> series and ec_x7 is the last...

ec_x7 clearly can't be an issue (just exports a symbol).

It's going to take a long time to isolate the problem this way,
since it doesn't appear at all promptly ... and since the system
exhibiting the regression is in use for "real work".

Too bad there's no "quilt import -R" option to import each of
these patches for reversion...

- Dave

