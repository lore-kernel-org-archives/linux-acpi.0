From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [2/6] 2.6.21-rc4: known regressions
Date: Tue, 20 Mar 2007 08:32:25 -0700
Message-ID: <45FFFE89.5050801@madrabbit.org>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <20070318184915.GV752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tapsys.com ([72.36.178.242]:35762 "EHLO tapsys.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933943AbXCTPcm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:32:42 -0400
In-Reply-To: <20070318184915.GV752@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

Adrian Bunk wrote:
> This email lists some known regressions in Linus' tree compared to 2.6.20.
[...]
> Subject    : ACPI regression with noapic
> References : http://lkml.org/lkml/2007/3/8/468
> Submitter  : Ray Lee <ray-lk@madrabbit.org>
> Status     : unknown

I finally have time to start bisecting this. I'll have something in the
next day.

Ray
