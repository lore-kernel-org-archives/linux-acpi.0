From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Tue, 22 Jan 2008 11:46:05 +0000
Message-ID: <20080122114605.GA23983@srcf.ucam.org>
References: <20071226020325.GA21099@srcf.ucam.org> <1200990809.7424.31.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:49379 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbYAVLqT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 06:46:19 -0500
Content-Disposition: inline
In-Reply-To: <1200990809.7424.31.camel@acpi-sony.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

On Tue, Jan 22, 2008 at 04:33:29PM +0800, Zhang Rui wrote:

> I have no obvious objection on either of these two proposals.
> But one thing to mention is that
> both of these two patches is written on the assumption that the
> brightness levels listed in _BCL method are in ascending order, while
> this is not stated in the ACPI spec.
> Is this a problem?

The driver already makes that assumption, and it's implicit in the spec.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
