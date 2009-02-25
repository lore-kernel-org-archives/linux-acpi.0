From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 16:51:52 +0000
Message-ID: <20090225165152.GA5981@srcf.ucam.org>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov> <20090225152409.GA4015@srcf.ucam.org> <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44978 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZBYQv6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 11:51:58 -0500
Content-Disposition: inline
In-Reply-To: <1235578705.4770.57.camel@penguin.lifesci.dundee.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Buzzard <jonathan@buzzard.me.uk>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org, john@neggie.net

On Wed, Feb 25, 2009 at 04:18:25PM +0000, Jonathan Buzzard wrote:

> Because it makes far more sense to have a user mode program to drive the
> features, and for the kernel to provide the necessary thin layer to
> access the features.

It makes sense for the kernel to provide a consistent abstraction of 
hardware functionality where possible. Almost every kernel driver could 
be rewritten in userspace - that doesn't make it a good idea.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
