From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 6 Mar 2009 10:15:33 +0000
Message-ID: <20090306101533.GA6408@srcf.ucam.org>
References: <20090306003941.GA32403@srcf.ucam.org> <20090306005234.GA32539@srcf.ucam.org> <1236330536.12838.2.camel@hughsie-work.lan> <1236332843.19146.4.camel@petitemort> <20090306095623.GA6014@srcf.ucam.org> <1236333861.19146.9.camel@petitemort> <20090306100951.GA6268@srcf.ucam.org> <1236334376.19146.11.camel@petitemort>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37350 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZCFKPj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2009 05:15:39 -0500
Content-Disposition: inline
In-Reply-To: <1236334376.19146.11.camel@petitemort>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Silverstone <dsilvers@simtec.co.uk>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Fri, Mar 06, 2009 at 10:12:56AM +0000, Daniel Silverstone wrote:

> I see. One other thing occurred to me. Is there any way for Hal to know
> that the notify stuff is in place and thus doesn't need to
> poll /proc/acpi/toshiba/keys? Otherwise it's going to poll it anyway
> which fails to remove the periodic wakeups.

No. Distributions should build without --enable-toshiba if they ship a 
kernel with this functionaliy.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
