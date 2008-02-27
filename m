From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real" device nodes
Date: Tue, 26 Feb 2008 18:19:31 -0800
Message-ID: <200802261819.31755.david-b@pacbell.net>
References: <200802222154.25204.david-b@pacbell.net> <200802252317.43717.david-b@pacbell.net> <20080226131058.GA8234@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:29129 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753126AbYB0CTe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 21:19:34 -0500
In-Reply-To: <20080226131058.GA8234@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Tuesday 26 February 2008, Henrique de Moraes Holschuh wrote:
> On Mon, 25 Feb 2008, David Brownell wrote:
> > int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
> >                                    const char *name);
> > 
> > Perhaps you disabled those warnings.  (And FWIW, I don't see any
> > reasonable way to handle such faults, so ignoring them is thus
> > the right "solution".)
> 
> You issue a printk warning the user, and try to continue.

That's not "handling" in any useful sense though.  There's no
question about "try" to continue, by the way ... from inside
the kernel this information is completely non-essential.

- Dave


