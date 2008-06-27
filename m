From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 04/10] acpi: adjust
 _acpi_{module,function}_namedefinitions
Date: Thu, 26 Jun 2008 22:00:53 -0700
Message-ID: <20080626220053.0a00a3c3.akpm@linux-foundation.org>
References: <200805010952.m419q3Jc031806@imap1.linux-foundation.org>
	<1209722812.22514.28.camel@linux-2bdv.site>
	<20080502054113.4e5839d9.akpm@linux-foundation.org>
	<1209737075.22514.79.camel@linux-2bdv.site>
	<9D39833986E69849A2A8E74C1078B6B3446FBD@orsmsx415.amr.corp.intel.com>
	<20080623124523.76f38d90.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0806262210520.2988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58195 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752235AbYF0FBP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jun 2008 01:01:15 -0400
In-Reply-To: <alpine.LFD.1.10.0806262210520.2988@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, trenn@suse.de, linux-acpi@vger.kernel.org, jbeulich@novell.com

On Thu, 26 Jun 2008 22:20:26 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:

> In the future, please simply do not accept
> patches to drivers/acpi/*/* (the ACPICA files) into -mm.

Nope.

> Instead, bounce them to the Linux/ACPI maintainer,
> who will bounce them to the ACPICA maintainer --
> which is the head of the stream for these sub-directories.

One of the things I do is to act as backup for leaky maintainers.  Many
years experience with hundreds of maintainers teaches me that they all
leak like sieves.  Stuff which we *want* in the kernel would just get
lost if we relied upon maintainers to be 100% lossless.

Now, if both the Linux/ACPI maintainer and the ACPICA maintainer were
lossless then OK, but that would be unprecedented in my experience. 
Even the best of the best (Mauro Chehab) loses stuff occasionally.

