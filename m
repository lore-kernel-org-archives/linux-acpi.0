From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Mon, 16 Mar 2015 21:01:40 +0000
Message-ID: <20150316210140.GA4678@srcf.ucam.org>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com>
 <55073E50.3010309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56166 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbbCPVBn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2015 17:01:43 -0400
Content-Disposition: inline
In-Reply-To: <55073E50.3010309@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 16, 2015 at 02:34:24PM -0600, Al Stone wrote:

> More a philosophical question -- the patch seems fine to me, personally, and
> for arm64, we have to have >= 5 anyway -- but would it make sense to just not
> acknowledge _REV and deprecate it from the kernel and the spec?  I'm already
> trying to get rid of _OSI because of such silliness and force requests to _OSC
> where they should be (granted, it will take some time...).

A bunch of systems verify that _REV returns >= 2 and change EC behaviour 
based on that, so killing it in the near term is unfortunately probably 
not an option.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
