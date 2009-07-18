From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT] hp-wmi: improved rfkill support for wifi
Date: Sat, 18 Jul 2009 18:03:32 +0100
Message-ID: <20090718170332.GA30201@srcf.ucam.org>
References: <4A61FE7D.9080409@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52340 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZGRRDf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jul 2009 13:03:35 -0400
Content-Disposition: inline
In-Reply-To: <4A61FE7D.9080409@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Frans Pop <elendil@planet.nl>, Larry Finger <Larry.Finger@lwfinger.net>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, Jul 18, 2009 at 05:55:25PM +0100, Alan Jenkins wrote:
> I borrowed a HP G7000 last week.  The hp-wmi driver seemed a bit
> confused about hard v.s. soft blocks on the wifi, so I fixed it based on
> acpidump output [1].  I hope this will work on other HP model numbers,
> but it would benefit from testing.  Any volunteers?

This looks good. Would you mind doing the same for bluetooth and wwan? 
What documentation I have suggests they should have the same behaviour.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
