From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: Export a couple of symbols.
Date: Thu, 17 Mar 2016 10:09:26 +0200
Message-ID: <20160317080926.GO1793@lahna.fi.intel.com>
References: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629AbcCQIJp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Mar 2016 04:09:45 -0400
Content-Disposition: inline
In-Reply-To: <1458174199-23615-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tn@semihalf.com>, David Daney <david.daney@cavium.com>

On Wed, Mar 16, 2016 at 05:23:19PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The acpi_dev_prop_read() and acpi_dev_prop_read_single() can be called
> by drivers.  Add EXPORT_SYMBOL_GPL to them to allow use by modular
> drivers.  This makes them consistent with acpi_dev_get_property() and
> acpi_node_get_property_reference() which are already exported.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> FWIW: We hope to submit soon Cavium Thunder networking patches that
> fail under modular builds without these exports.

You should not be using these functions directly in drivers.
