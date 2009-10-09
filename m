From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 2/2] [PATCH 2/2] ACPI: generic initramfs table override
	support #3
Date: Fri, 9 Oct 2009 21:19:08 +0100
Message-ID: <20091009201908.GA1139@srcf.ucam.org>
References: <20091009195508.694274257@suse.com> <20091009195907.635574715@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58521 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804AbZJIUUA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2009 16:20:00 -0400
Content-Disposition: inline
In-Reply-To: <20091009195907.635574715@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-acpi@vger.kernel.org, =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Jan Beulich <JBeulich@novell.com>, Thomas Renninger <trenn@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@hera.kernel.org>

On Fri, Oct 09, 2009 at 03:55:10PM -0400, Jeff Mahoney wrote:

> This version provides the infrastructure to override any ACPI table, but
> only provides support for overriding DSDT. If other tables are desired,
> extending the support is trivial.

I'm really unenthusiastic about this. The majority of use cases appear 
to be people working around Linux bugs and never reporting the bugs to 
us, leaving everybody worse off.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
