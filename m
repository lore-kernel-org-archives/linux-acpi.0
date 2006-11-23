From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc6: known regressions (v4)
Date: Wed, 22 Nov 2006 16:04:25 -0800
Message-ID: <200611221604.26982.david-b@pacbell.net>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:22867 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1757242AbWKWAlM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 19:41:12 -0500
In-Reply-To: <20061121212424.GQ5200@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@osdl.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tuesday 21 November 2006 1:24 pm, Adrian Bunk wrote:

> Subject    : ACPI: AE_TIME errors
> References : http://lkml.org/lkml/2006/11/15/12
> Submitter  : David Brownell <david-b@pacbell.net>
> Handled-By : Len Brown <len.brown@intel.com>
>              Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> Status     : problem is being debugged

I've not seen this in over 3 days now, and am willing to believe that
the previous instance (after manually reverting the patch identified
by Linus) was a fluke ... it's certainly not the critical/blocking kind
of issue it had previously been.

- Dave
