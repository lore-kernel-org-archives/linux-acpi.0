From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Sony laptop: Some Sony Vaia laptops do not enable wwan power by default.
Date: Wed, 22 Apr 2009 20:50:34 +0100
Message-ID: <20090422195034.GA32375@srcf.ucam.org>
References: <20090422185351.AB41AF88CE@sepang.rtg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52158 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZDVTum (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 15:50:42 -0400
Content-Disposition: inline
In-Reply-To: <20090422185351.AB41AF88CE@sepang.rtg.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tim Gardner <timg@tpi.com>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 22, 2009 at 12:53:51PM -0600, Tim Gardner wrote:
> Mattia,
> 
> Does this patch makes sense for just the Vaio? I've had positive feedback from
> the tester in the bug report.

It'd make more sense to change the wwan power option to use rfkill. That 
way it'll be powered up at appropriate times.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
