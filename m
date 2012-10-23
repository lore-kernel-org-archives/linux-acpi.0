From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Simplify conditional that has the same effect no
 matter what.
Date: Tue, 23 Oct 2012 03:27:27 +0100
Message-ID: <20121023022727.GA13880@srcf.ucam.org>
References: <alpine.DEB.2.02.1210221738310.5975@oneiric>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50304 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab2JWC1c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Oct 2012 22:27:32 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1210221738310.5975@oneiric>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl

On Mon, Oct 22, 2012 at 05:40:36PM -0400, Robert P. J. Day wrote:

>   not sure if there's something weirdly subtle happening here, but
> this looks like a straightforward simplification.

There is - it provides a hint to lockdep, but it should probably have a 
comment explaining it. See 
https://bugzilla.kernel.org/show_bug.cgi?id=14553 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
