From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Bugme-new] [Bug 9957] New: Battery gives me now two batterys, but only one is present
Date: Thu, 14 Feb 2008 14:05:15 +0000
Message-ID: <20080214140513.GA12412@srcf.ucam.org>
References: <bug-9957-10286@http.bugzilla.kernel.org/> <20080213123112.5df7fea3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:49661 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbYBNOFk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 09:05:40 -0500
Content-Disposition: inline
In-Reply-To: <20080213123112.5df7fea3.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: patrick.matthaei@web.de, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Feb 13, 2008 at 12:31:12PM -0800, Andrew Morton wrote:

> And it's a regression.

No, it's a feature. You've configured in both the legacy and the sysfs 
interfaces for the battery, and hal is picking up both of them. There's 
a patch upstream to make hal realise that they're the same device, but 
the alternative is just to disable one of the options.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
