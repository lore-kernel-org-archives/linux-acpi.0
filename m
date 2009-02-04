From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] ACPI: add "auto" to acpi_enforce_resources
Date: Wed, 4 Feb 2009 13:17:09 +0000
Message-ID: <20090204131708.GA2739@srcf.ucam.org>
References: <20090125210520.GA12963@dreamland.darkstar.lan> <200901291130.35434.trenn@suse.de> <68676e00901290716g1aabd6c0p1e5202fbdbc659a4@mail.gmail.com> <alpine.LFD.2.00.0902040042570.9833@localhost.localdomain> <20090204060513.GA28321@srcf.ucam.org> <498953DF.5050306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41546 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZBDNRQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 08:17:16 -0500
Content-Disposition: inline
In-Reply-To: <498953DF.5050306@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Luca Tettamanti <kronos.it@gmail.com>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, khali@linux-fr.org

On Wed, Feb 04, 2009 at 09:37:51AM +0100, Hans de Goede wrote:

> Len, Matthew, what is you opinion of the proposed auto setting for 
> acpi_enforce_resources, which is meant to mean strict on known problematic 
> systems and lax on others?

Personally, I'd rather that it was "strict" on everything. We might 
break some existing setups, but they're already working mostly by luck.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
