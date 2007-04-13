From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 135/140] ACPI: bay: make bay a platform driver
Date: Fri, 13 Apr 2007 11:25:56 -0600
Message-ID: <200704131125.57081.bjorn.helgaas@hp.com>
References: <11708743541314-git-send-email-lenb@kernel.org> <2b167c01190b647c976e7fab312f2e3d3b3a785f.1170873819.git.len.brown@intel.com> <11708745533065-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:48263 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbXDMR0L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Apr 2007 13:26:11 -0400
In-Reply-To: <11708745533065-git-send-email-lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

On Wednesday 07 February 2007 11:52, Len Brown wrote:
> -	new_bay = kmalloc(GFP_ATOMIC, sizeof(*new_bay));
> +	new_bay = kzalloc(GFP_ATOMIC, sizeof(*new_bay));
>  	INIT_LIST_HEAD(&new_bay->list);

You might want to check for kzalloc failure.
