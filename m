From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 08/12] thermal: add sanity check for the passive
	attribute
Date: Tue, 17 Nov 2009 22:33:40 +0000
Message-ID: <20091117223340.GB23531@srcf.ucam.org>
References: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46820 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbZKQWe5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 17:34:57 -0500
Content-Disposition: inline
In-Reply-To: <200911172227.nAHMRZX8023365@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, elendil@planet.nl, rui.zhang@intel.com

As noted before, I'm not a fan of this approach - I can't think of many 
reasons why it'd be necessary to use temperatures below 1 degree C, but 
this constraint isn't present anywhere else in the thermal code and, 
really, there's plenty of things that people can break if they just echo 
incorrect values into /sys.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
