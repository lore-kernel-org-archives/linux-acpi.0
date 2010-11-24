From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 6/8] hwmon driver for ACPI 4.0 power meters
Date: Wed, 24 Nov 2010 23:36:35 +0000
Message-ID: <20101124233635.GB12372@srcf.ucam.org>
References: <200909181941.n8IJf91g002548@imap1.linux-foundation.org> <20101124213936.GA9829@srcf.ucam.org> <20101124232159.GX14383@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51626 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab0KXXgy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2010 18:36:54 -0500
Content-Disposition: inline
In-Reply-To: <20101124232159.GX14383@tux1.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, pavel@ucw.cz, rui.zhang@intel.com

On Wed, Nov 24, 2010 at 03:21:59PM -0800, Darrick J. Wong wrote:

> As I recall, Pavel had an objection that it wasn't clear to him that ACPI
> advertising a capping ability necessarily meant that the platform hardware
> would actually _enforce_ that cap, so I put in a DMI hook so that the cap only
> appears on systems where ACPI advertises the ability /and/ someone can verify
> that it's enforced outside software (either by patching the DMI table or by
> supplying a module parameter).
> 
> I guess we were afraid that someone would build an ACPI power meter and then
> require software to read the cap out of ACPI and enforce it(??) though I can't
> find a link to that discussion.  I'll just attach it below, since the marc.info
> archive of mm-commits doesn't seem to have caught it.

The spec defines bit 2 of the capabilities list as "Power meter supports 
hardware enforced limit" - I don't think we're meant to worry about the 
OS here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
