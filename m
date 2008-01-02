From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while suspended (rev. 2)
Date: Wed, 2 Jan 2008 12:29:42 -0800
Message-ID: <200801021229.43555.david-b@pacbell.net>
References: <200801020032.45529.rjw@sisk.pl> <20080102175400.3C2E0EF588@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20080102201451.GC3985@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:46730 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754170AbYABU3q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 15:29:46 -0500
In-Reply-To: <20080102201451.GC3985@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: kay.sievers@vrfy.org, a.zummo@towertech.it, stern@rowland.harvard.edu, rjw@sisk.pl, pavel@suse.cz, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, gregkh@suse.de, akpm@linux-foundation.org

On Wednesday 02 January 2008, Ingo Molnar wrote:
> 
> then please provide a kernel config option for the new driver to take 
> over 10:135 too. There's nothing worse to the adoption of new kernel 
> features necessiating user-space attention. I've got several images of 
> old distros that i dont want to reconfigure in any way, and it would be 
> nice to have a drop-in /dev/rtc replacement for them. Really. This is 
> how we do it for just about everything else too.

I'll let someone else chase that particular issue.  :)

