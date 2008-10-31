From: Matthew Garrett <mjg@redhat.com>
Subject: Re: Build error with latest kernel
Date: Fri, 31 Oct 2008 02:53:12 +0000
Message-ID: <20081031025312.GA11206@srcf.ucam.org>
References: <1225377756.3689.5.camel@localhost.localdomain> <1225421122.2665.18.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58476 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbYJaCxZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Oct 2008 22:53:25 -0400
Content-Disposition: inline
In-Reply-To: <1225421122.2665.18.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>, "airlied@linux.ie" <airlied@linux.ie>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I don't think it's worth a config option - Len's patch looks like the 
right way to solve this.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
