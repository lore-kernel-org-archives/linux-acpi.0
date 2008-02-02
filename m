From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Fri, 1 Feb 2008 23:36:10 -0500
Message-ID: <200802012336.10687.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <200801311417.57469.lenb@kernel.org> <1201859637.14573.41.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42992 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761324AbYBBFTf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 00:19:35 -0500
In-Reply-To: <1201859637.14573.41.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Friday 01 February 2008 04:53, Thomas Renninger wrote:

> > That gives you complete and total control over what AML gets run
> I doubt that. You said there can be any number of SSDTs. If you know
> what you are doing..., but how do you explain someone in a bug that he
> has to collect all SSDTs (some via acpidump --addr xy) open an editor,
> paste them into the DSDT and so on...

Dynamic SSDT's are loaded from OpRegions by address.

If you want to change the AML in those opregions,
you have to acquire it with acpidump --addr xy.
That is true no mater what override scheme you're using.

However, if you don't want to modify the dynamic SSDT,
then it does not have to be dumped -- it will continue
to be accessed via Load() of the opregion; and it
is totally unrelated to a DSDT or a DSDT+static-SSDT override.

I am doubtful that SSDT override support past what
we have already justifies its own complexity.

-Len
