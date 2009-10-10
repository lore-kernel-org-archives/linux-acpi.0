From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 2/2] [PATCH 2/2] ACPI: generic initramfs table override
	support #3
Date: Sat, 10 Oct 2009 15:43:46 +0100
Message-ID: <20091010144346.GA15681@srcf.ucam.org>
References: <20091009195508.694274257@suse.com> <20091009195907.635574715@suse.com> <20091009201908.GA1139@srcf.ucam.org> <4AD09AEA.70107@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55750 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397AbZJJOoi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Oct 2009 10:44:38 -0400
Content-Disposition: inline
In-Reply-To: <4AD09AEA.70107@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-acpi@vger.kernel.org, =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Jan Beulich <JBeulich@novell.com>, Thomas Renninger <trenn@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@hera.kernel.org>

On Sat, Oct 10, 2009 at 10:32:10AM -0400, Jeff Mahoney wrote:

> I agree. In an ideal world this would be unnecessary. It's true that
> ACPI bugs have become must less common than they used to be but I think
> users would prefer their machines be usable while the ACPI developers
> are diagnosing why they need a workaround in the first place.

If that were the tradeoff then I'd be happy, but what tends to happen is 
that the section of users who are able to help us debug just work around 
it instead and the ones who have no idea how to report a bug end up with 
broken machines.

> In some cases it's just that the MS AML compiler is just so much more
> lax than the Intel one. I had a notebook where I had to extract, fix,
> and rebuild my DSDT and then it worked fine. Without the ability to
> override it, I would've been stuck.

For a user who can do these fixups themselves, it's easy enough to 
rebuild a kernel with the DSDT override. However, pretty much every 
recent ACPI bug I've seen has had nothing to do with the MS compiler's 
less strict error checking - we run the in-kernel interpreter in a lax 
mode that's intended to be bug for bug compatible with the Microsoft 
one.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
