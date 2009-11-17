From: Frans Pop <elendil@planet.nl>
Subject: Re: [patch 08/12] thermal: add sanity check for the passive attribute
Date: Tue, 17 Nov 2009 23:42:55 +0100
Message-ID: <200911172342.58802.elendil@planet.nl>
References: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org> <20091117223340.GB23531@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml103.kpnxchange.com ([195.121.3.7]:54922 "EHLO
	CPSMTPM-EML103.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756501AbZKQWmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:42:54 -0500
In-Reply-To: <20091117223340.GB23531@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Tuesday 17 November 2009, Matthew Garrett wrote:
> As noted before, I'm not a fan of this approach - I can't think of many
> reasons why it'd be necessary to use temperatures below 1 degree C, but
> this constraint isn't present anywhere else in the thermal code and,
> really, there's plenty of things that people can break if they just echo
> incorrect values into /sys.

Personally I'd be in favor of adding more sanity checks rather than 
removing them. The cost of the check is virtually zero.

Cheers,
FJP
