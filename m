From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [patch 2/2] [PATCH 2/2] ACPI: generic initramfs table override
 support #3
Date: Sat, 10 Oct 2009 10:32:10 -0400
Message-ID: <4AD09AEA.70107@suse.com>
References: <20091009195508.694274257@suse.com> <20091009195907.635574715@suse.com> <20091009201908.GA1139@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45205 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761502AbZJJOcv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Oct 2009 10:32:51 -0400
In-Reply-To: <20091009201908.GA1139@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, Jan Beulich <JBeulich@novell.com>, Thomas Renninger <trenn@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@hera.kernel.org>

On 10/09/2009 04:19 PM, Matthew Garrett wrote:
> On Fri, Oct 09, 2009 at 03:55:10PM -0400, Jeff Mahoney wrote:
> 
>> This version provides the infrastructure to override any ACPI table, but
>> only provides support for overriding DSDT. If other tables are desired,
>> extending the support is trivial.
> 
> I'm really unenthusiastic about this. The majority of use cases appear 
> to be people working around Linux bugs and never reporting the bugs to 
> us, leaving everybody worse off.

I agree. In an ideal world this would be unnecessary. It's true that
ACPI bugs have become must less common than they used to be but I think
users would prefer their machines be usable while the ACPI developers
are diagnosing why they need a workaround in the first place.

In some cases it's just that the MS AML compiler is just so much more
lax than the Intel one. I had a notebook where I had to extract, fix,
and rebuild my DSDT and then it worked fine. Without the ability to
override it, I would've been stuck.

BTW, a similar version of this patch was committed to mainline in Feb
2008 though it was reverted shortly after that. Judging from the commit
message, it's because it reintroduced the early userspace bugs. I
believe this patch addresses that by not allowing the usermode helper to
run until rootfs_initcall has been completed.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
