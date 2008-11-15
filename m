From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 18:49:00 +0000
Message-ID: <20081115184900.GA10685@srcf.ucam.org>
References: <200811081637.45099.arvidjaar@mail.ru> <200811152017.56926.arvidjaar@mail.ru> <20081115172052.GA9537@srcf.ucam.org> <200811152142.18890.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53938 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYKOStF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 13:49:05 -0500
Content-Disposition: inline
In-Reply-To: <200811152142.18890.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Ok, so they can get unsynchronised. I agree with Thomas that it's 
desirable to remove one of them in that case. As you and Len have 
pointed out, the difficulty is in knowing which one to remove.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
