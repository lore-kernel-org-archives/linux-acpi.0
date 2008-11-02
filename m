From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Sun, 2 Nov 2008 13:26:50 +0000
Message-ID: <20081102132650.GA13084@srcf.ucam.org>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <490B4014.4040009@tuffmail.co.uk> <490B70A3.8010108@tuffmail.co.uk> <20081102040008.GB29606@khazad-dum.debian.net> <490D8C4E.3010201@tuffmail.co.uk> <20081102130655.GA12766@srcf.ucam.org> <490DAA33.7010905@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52582 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbYKBN0z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Nov 2008 08:26:55 -0500
Content-Disposition: inline
In-Reply-To: <490DAA33.7010905@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 02, 2008 at 01:25:07PM +0000, Alan Jenkins wrote:

> No, the current rfkill core forces the device to restore the state on 
> resume.  So it can't be of sync after resume.  And there's no way for 
> the platform driver to affect this behaviour, aside from illegally 
> generating input events.

Oh, so it does. Yeah, in that case I don't see any real point in 
changing it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
