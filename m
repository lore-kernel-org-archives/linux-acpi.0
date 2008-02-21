From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Machine shutdown after resume from S3
Date: Thu, 21 Feb 2008 19:02:50 +0000
Message-ID: <20080221190249.GA13202@srcf.ucam.org>
References: <200802201837.22443.herton@mandriva.com.br> <20080221174643.32B0A3608D@smtp02.mtu.ru> <20080221184326.0386A3271D@smtp02.mtu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:57593 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYBUTDH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 14:03:07 -0500
Content-Disposition: inline
In-Reply-To: <20080221184326.0386A3271D@smtp02.mtu.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-acpi@vger.kernel.org

On Thu, Feb 21, 2008 at 09:43:30PM +0300, Andrey Borzenkov wrote:

> wait a bit; suspend to RAM is S1 not S3.

Not on any even vaguely modern hardware, no. In any case, the Classmate 
reboots before entering userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
