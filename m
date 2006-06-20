From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Mon, 19 Jun 2006 22:16:39 -0700
Message-ID: <20060619221639.3adbbf34.rdunlap@xenotime.net>
References: <4491BC6B.5000704@oracle.com>
	<20060619203333.5e897ead.akpm@osdl.org>
	<87lkrstrgy.fsf@benpfaff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:42645 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751219AbWFTFNw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 01:13:52 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-acpi@vger.kernel.org>; Mon, 19 Jun 2006 22:13:51 -0700
In-Reply-To: <87lkrstrgy.fsf@benpfaff.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: blp@cs.stanford.edu, bcollins@ubuntu.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 20:51:09 -0700 Ben Pfaff wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Thu, 15 Jun 2006 13:00:43 -0700
> > Randy Dunlap <randy.dunlap@oracle.com> wrote:
> >
> >> [UBUNTU:acpi] Add IBM R60E laptop to proc-idle blacklist.
> 
> >> +	{ set_max_cstate, "IBM ThinkPad R40e", {
> >> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
> >> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
> >
> > It seems that every R40e in the world is in that table.
> 
> The email says R60e.
> The string says R40e.
> Which is correct?

Good question for Ben.  Ben??

Current ubuntu-dapper git is still like this.

---
~Randy
