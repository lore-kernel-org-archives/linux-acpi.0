From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 08/12] thermal: add sanity check for the passive
	attribute
Date: Tue, 17 Nov 2009 22:52:04 +0000
Message-ID: <20091117225204.GB24273@srcf.ucam.org>
References: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org> <20091117223340.GB23531@srcf.ucam.org> <200911172342.58802.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52875 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbZKQWxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 17:53:20 -0500
Content-Disposition: inline
In-Reply-To: <200911172342.58802.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Tue, Nov 17, 2009 at 11:42:55PM +0100, Frans Pop wrote:
> On Tuesday 17 November 2009, Matthew Garrett wrote:
> > As noted before, I'm not a fan of this approach - I can't think of many
> > reasons why it'd be necessary to use temperatures below 1 degree C, but
> > this constraint isn't present anywhere else in the thermal code and,
> > really, there's plenty of things that people can break if they just echo
> > incorrect values into /sys.
> 
> Personally I'd be in favor of adding more sanity checks rather than 
> removing them. The cost of the check is virtually zero.

It makes something that's potentially useful to someone impossible, for 
the benefit of people who can crash their system in half a dozen other 
ways by writing inappropriate values into other files.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
