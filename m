From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Wed, 12 Jun 2013 14:40:02 +0100
Message-ID: <20130612134002.GA15317@srcf.ucam.org>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53831 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab3FLNkJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 09:40:09 -0400
Content-Disposition: inline
In-Reply-To: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: linux-acpi@vger.kernel.org, Rob E Russell <robr@us.ibm.com>

On Tue, Jun 11, 2013 at 02:30:30PM -0700, Larry Baker wrote:
> I have an IBM System x3650 M3 with an Intel Xeon L5630 processor.  My IBM support team alerted me to an issue with C6 states for those processors when running Linux and the intel_idle kernel module is used.  The IBM solutions page, http://www-947.ibm.com/support/entry/portal/docdisplay?lndocid=migr-5091901, recommends disabling intel_idle.  I propose intel_idle disable C6 for the affected processors.

As you note:

> > Workaround: 
> > It is possible for the BIOS to contain a workaround for this erratum.

Are you actually seeing this specific problem? If so, you should 
probably request a firmware update from IBM. If that's not a 
possibility, and if it is necessary to disable package C6 in this 
situation, it'd be nice to determine what the BIOS workaround actually 
does and limit the quirk to that case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
