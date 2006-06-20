From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Mon, 19 Jun 2006 20:51:09 -0700
Message-ID: <87lkrstrgy.fsf@benpfaff.org>
References: <4491BC6B.5000704@oracle.com>
	<20060619203333.5e897ead.akpm@osdl.org>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965459AbWFTDv1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 15 Jun 2006 13:00:43 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
>> [UBUNTU:acpi] Add IBM R60E laptop to proc-idle blacklist.

>> +	{ set_max_cstate, "IBM ThinkPad R40e", {
>> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
>> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
>
> It seems that every R40e in the world is in that table.

The email says R60e.
The string says R40e.
Which is correct?
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org
