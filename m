From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Regression 2.6.39-rc1 for sony-laptop
Date: Fri, 1 Apr 2011 18:22:41 +0100
Message-ID: <20110401172241.GA26851@srcf.ucam.org>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42354 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852Ab1DARWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2011 13:22:55 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: anssi.hannula@iki.fi, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, error27@gmail.com, malattia@linux.it, linux-kernel@vger.kernel.org

On Fri, Apr 01, 2011 at 07:16:43PM +0200, Andrea Gelmini wrote:

> Git bisect blames this commit:

Pretty convinced that git bisect's got that wrong, given that it doesn't 
touch any Sony code. I'll take a look at the Sony patches, thanks for 
the report!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
