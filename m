From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Thu, 19 Mar 2009 21:56:33 +0000
Message-ID: <20090319215633.GA25279@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org> <20090319214914.GN29624@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43775 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761098AbZCSV4j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 17:56:39 -0400
Content-Disposition: inline
In-Reply-To: <20090319214914.GN29624@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Thu, Mar 19, 2009 at 10:49:14PM +0100, Norbert Preining wrote:

> One question: Should I apply the patches Mattia posted some time ago 
> (9 of them if I remember correctly) and your patch on top of them, or
> apply your patch to current -rc8?

Mine doesn't depend on any of Mattia's patches, but should work with 
them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
