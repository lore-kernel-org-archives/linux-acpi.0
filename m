From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] ACPI processor: Remove unneeded variable passed by acpi_processor_hotadd_init
Date: Tue, 17 Jan 2012 17:22:44 +0100
Message-ID: <201201171722.45057.trenn@suse.de>
References: <1326817230-79711-1-git-send-email-trenn@suse.de> <1326817230-79711-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40052 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977Ab2AQQWq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 11:22:46 -0500
In-Reply-To: <1326817230-79711-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, deepthi@linux.vnet.ibm.com, Bjorn Helgaas <bhelgaas@google.com>, "Jiang, Yunhong" <yunhong.jiang@intel.com>

On Tuesday, January 17, 2012 05:20:29 PM Thomas Renninger wrote:
...
> +	if (acpi_map_lsapic(handle, &pr-id))
oops, blindly used guilt import.
I resend.
Sorry,

   Thomas
