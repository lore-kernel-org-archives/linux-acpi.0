From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 03/13] libata: separate out ata_dev_reread_id()
Date: Sat, 28 Apr 2007 14:53:53 -0400
Message-ID: <46339841.2030604@garzik.org>
References: <11772636651116-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53480 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbXD1SyC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Apr 2007 14:54:02 -0400
In-Reply-To: <11772636651116-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ata_dev_reread_id() from ata_dev_revalidate().
> ata_dev_reread_id() reads IDENTIFY page and determines whether the
> same device is still there.  ata_dev_revalidate() reconfigures after
> reread completes.  This will be used by ACPI update.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   47 ++++++++++++++++++++++++++++++++------------
>  drivers/ata/libata.h      |    3 +-
>  2 files changed, 36 insertions(+), 14 deletions(-)

ACK, though I think you'll have to rediff due to a Mark Lord patch


