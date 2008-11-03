From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/7] [sony-laptop] add control over wifi power in Sony laptops
Date: Mon, 3 Nov 2008 10:32:18 +0000
Message-ID: <20081103103218.GA28263@srcf.ucam.org>
References: <1225705280-12775-1-git-send-email-malattia@linux.it> <1225705280-12775-2-git-send-email-malattia@linux.it> <1225705280-12775-3-git-send-email-malattia@linux.it> <1225705280-12775-4-git-send-email-malattia@linux.it> <1225705280-12775-5-git-send-email-malattia@linux.it> <1225705280-12775-6-git-send-email-malattia@linux.it> <1225705280-12775-7-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41873 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYKCKcZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 05:32:25 -0500
Content-Disposition: inline
In-Reply-To: <1225705280-12775-7-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>

On Mon, Nov 03, 2008 at 06:41:19PM +0900, Mattia Dongili wrote:

> Sony laptops have a single hardware rfkill switch, which controls
> several wireless devices: wifi, bluetooth, wwan. The code to
> selectively control bluetooth and wwan is already present. This
> patch adds handling of wifi.

Please don't add more custom radio control switches. It'd be better to 
add rfkill support. Otherwise we have even more stuff in /sys to carry 
around for ages before deprecating.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
