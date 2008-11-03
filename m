From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/7] [sony-laptop] add control over wifi power in Sony laptops
Date: Mon, 3 Nov 2008 10:57:25 +0000
Message-ID: <20081103105725.GA28527@srcf.ucam.org>
References: <1225705280-12775-1-git-send-email-malattia@linux.it> <1225705280-12775-2-git-send-email-malattia@linux.it> <1225705280-12775-3-git-send-email-malattia@linux.it> <1225705280-12775-4-git-send-email-malattia@linux.it> <1225705280-12775-5-git-send-email-malattia@linux.it> <1225705280-12775-6-git-send-email-malattia@linux.it> <1225705280-12775-7-git-send-email-malattia@linux.it> <20081103103218.GA28263@srcf.ucam.org> <490ED8B6.8000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44067 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbYKCK53 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 05:57:29 -0500
Content-Disposition: inline
In-Reply-To: <490ED8B6.8000206@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Yanovich <ynvich@gmail.com>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Mon, Nov 03, 2008 at 12:55:50PM +0200, Sergey Yanovich wrote:

> Do you mean that the patch should use some other file instead of 
> /sys/devices/platform/sony-laptop/wifipower for input/output?

Yes. It should register an rfkill device, which will then be exposed via 
/sys/class/rfkill. Checkout out Documentation/rfkill.txt.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
