From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fix polling policy in the absence of _TZP
Date: Wed, 14 May 2008 11:14:33 +0100
Message-ID: <20080514101433.GA29757@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <200805132319.39947.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:51593 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbYENKO4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 06:14:56 -0400
Content-Disposition: inline
In-Reply-To: <200805132319.39947.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, May 13, 2008 at 11:19:39PM -0400, Len Brown wrote:
> On Tuesday 13 May 2008, Matthew Garrett wrote:
> > Fix Linux to conform to 11.3.18 of the ACPI spec 3.0. In the absence of 
> > a _TZP method, we should be polling at a default frequency. While it can 
> > be argued that "0" is a default frequency, I don't think that's what the 
> > spec authors had in mind.
> 
> Actually it is what the spec authors had in mind,
> and the spec is wrong.  Yes, I can provide documentation

Hmm. Ok, I'll handle this differently.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
