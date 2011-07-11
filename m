From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH v2] acpi: introduce "acpi_rsdp=" parameter for kdump
Date: Mon, 11 Jul 2011 18:27:35 +0100
Message-ID: <20110711172735.GB15887@srcf.ucam.org>
References: <E8CC3FDD41FF9Findou.takao@jp.fujitsu.com>
 <20110711172318.GA18279@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50161 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256Ab1GKR1t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2011 13:27:49 -0400
Content-Disposition: inline
In-Reply-To: <20110711172318.GA18279@dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, linux-kernel@vger.kernel.org, amwang@redhat.com, ebiederm@xmission.com, vgoyal@redhat.com, rdunlap@xenotime.net, lenb@kernel.org, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jul 11, 2011 at 01:23:18PM -0400, Konrad Rzeszutek Wilk wrote:

> How will the tools get the physical address of the RSDP?

It's exposed in sysfs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
