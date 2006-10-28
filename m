From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] acpi: fix single linked list manipulation
Date: Sat, 28 Oct 2006 20:02:54 +0100
Message-ID: <20061028190254.GA7070@infradead.org>
References: <20061028185313.GK9973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:1187 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751354AbWJ1TC4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Oct 2006 15:02:56 -0400
Content-Disposition: inline
In-Reply-To: <20061028185313.GK9973@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sun, Oct 29, 2006 at 03:53:13AM +0900, Akinobu Mita wrote:
> This patch fixes single linked list manipulation for sub_driver.
> If the remving entry is not on the head of the sub_driver list,
> it goes into infinate loop.
> 
> Though that infinate loop doesn't happen. Because the only user of
> acpi_pci_register_dirver() is acpiphp.

Any chance to just switch the driver to use the list.h APIs instead
of opencoding lists?

