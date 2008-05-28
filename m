From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 2/2] PNPACPI: fix shareable IRQ encode/decode
Date: Wed, 28 May 2008 22:58:47 +0200
Message-ID: <483DC787.6070700@keyaccess.nl>
References: <20080527224915.412211349@ldl.fc.hp.com> <20080527224938.681457358@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:56484 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYE1Uzv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 May 2008 16:55:51 -0400
In-Reply-To: <20080527224938.681457358@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Tom Jaeger <ThJaeger@gmail.com>

On 28-05-08 00:49, Bjorn Helgaas wrote:

> When we encode IRQ resources, we should use the "shareable"
> flag we got from _PRS rather than guessing based on the
> IRQ trigger mode.
> 
> This is based on a patch by Tom Jaeger <ThJaeger@gmail.com>:
>     http://bugzilla.kernel.org/show_bug.cgi?id=9487#c32
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Not-commented-on-by: Rene Herman <rene.herman@gmail.com>

Makes sense patchwise but one would expect that it wasn't that way to 
start with due to perhaps some/many/most BIOSen not encoding the flag 
correctly in _PRS. Don't know ACPI though...

Rene.
