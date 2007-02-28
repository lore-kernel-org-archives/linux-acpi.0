From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Wed, 28 Feb 2007 23:13:18 +0200
Message-ID: <20070228211318.GB4301@mellanox.co.il>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org> <20070226220152.GA29575@stusta.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:36239 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbXB1VMr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Feb 2007 16:12:47 -0500
Content-Disposition: inline
In-Reply-To: <20070226220152.GA29575@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org

>Subject    : ThinkPad T60: no screen after suspend to RAM
>References : http://lkml.org/lkml/2007/2/22/391
>Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
>Handled-By : Ingo Molnar <mingo@elte.hu>
>Status     : unknown

Just reproduced this in -rc2.
Another thing I noticed:
with 2.6.20, pressing Fn/F4 generates an ACPI event and triggers suspend to RAM.

On 2.6.21-rc2, after resume (when the box is accessible from network),
pressing Fn/F4 again does not seem to have any effect.


-- 
MST
