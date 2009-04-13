From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/6] sony-laptop: always try to unblock rfkill on load
Date: Mon, 13 Apr 2009 16:46:12 +0100
Message-ID: <20090413154612.GC11971@srcf.ucam.org>
References: <1239535591-15514-1-git-send-email-malattia@linux.it> <1239535591-15514-2-git-send-email-malattia@linux.it> <1239535591-15514-3-git-send-email-malattia@linux.it> <1239535591-15514-4-git-send-email-malattia@linux.it> <1239535591-15514-5-git-send-email-malattia@linux.it> <1239535591-15514-6-git-send-email-malattia@linux.it> <1239535591-15514-7-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46448 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbZDMPqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 11:46:15 -0400
Content-Disposition: inline
In-Reply-To: <1239535591-15514-7-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthias Welwarsky <matze@welwarsky.de>

On Sun, Apr 12, 2009 at 08:26:31PM +0900, Mattia Dongili wrote:
> This fixes an inconsistent behaviour when loading the driver with the
> switch on or off. In the former case you would also need to soft unblock
> the switch via the sysfs file entries to really disable rfkill, in the
> latter you wouldn't.
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> Cc: Matthias Welwarsky <matze@welwarsky.de>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
