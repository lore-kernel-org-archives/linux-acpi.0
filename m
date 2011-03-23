From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Handle multiple button devices with the same name
Date: Wed, 23 Mar 2011 10:59:47 +0000
Message-ID: <20110323105947.GB29657@srcf.ucam.org>
References: <1299876888-6239-1-git-send-email-mjg@redhat.com> <alpine.LFD.2.02.1103230055200.10549@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47884 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386Ab1CWK7w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 06:59:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103230055200.10549@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, Mar 23, 2011 at 12:56:59AM -0400, Len Brown wrote:
> > It's valid for ACPI to have multiple devices with the same name. It's not
> > valid for us to create multiple identical directories in /proc. Let's
> > put some effort into uniqueness.
> 
> I chose the patch that deletes this code instead.

Works for me.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
