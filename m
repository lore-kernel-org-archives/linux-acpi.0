From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] Reduce ACPI resource conflict message to KERN_INFO
Date: Tue, 2 Mar 2010 16:14:33 -0700
Message-ID: <201003021614.34026.bjorn.helgaas@hp.com>
References: <1267564152-11048-1-git-send-email-chase.douglas@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:20855 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab0CBXOf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2010 18:14:35 -0500
In-Reply-To: <1267564152-11048-1-git-send-email-chase.douglas@ubuntu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chase Douglas <chase.douglas@ubuntu.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 02 March 2010 02:09:12 pm Chase Douglas wrote:
> -			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
> +			printk(KERN_INFO "ACPI: %s resource %s [0x%llx-0x%llx]"
>  			       " conflicts with ACPI region %s"
>  			       " [0x%llx-0x%llx]\n",
> -			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> -			       ? KERN_WARNING : KERN_ERR,
>  			       ioport ? "I/O" : "Memory", res->name,
>  			       (long long) res->start, (long long) res->end,
>  			       res_list_elem->name,

Since you're touching this anyway, can you convert this to use %pR?

Bjorn
