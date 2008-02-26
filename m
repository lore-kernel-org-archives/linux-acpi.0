From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real" device nodes
Date: Tue, 26 Feb 2008 10:10:58 -0300
Message-ID: <20080226131058.GA8234@khazad-dum.debian.net>
References: <200802222154.25204.david-b@pacbell.net> <200802252245.43282.david-b@pacbell.net> <1203977422.10256.91.camel@acpi-hp-zz.sh.intel.com> <200802252317.43717.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49710 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550AbYBZNLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 08:11:03 -0500
Content-Disposition: inline
In-Reply-To: <200802252317.43717.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Mon, 25 Feb 2008, David Brownell wrote:
> int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
>                                    const char *name);
> 
> Perhaps you disabled those warnings.  (And FWIW, I don't see any
> reasonable way to handle such faults, so ignoring them is thus
> the right "solution".)

You issue a printk warning the user, and try to continue.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
