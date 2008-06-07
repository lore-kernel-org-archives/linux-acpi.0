From: "Guillaume Chazarain" <guichaz@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, disabling EC GPE
Date: Sat, 7 Jun 2008 16:31:50 +0200
Message-ID: <3d8471ca0806070731o98d62a9lab6caf394aa60277@mail.gmail.com>
References: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com>
	 <20080606235526.783acc83.akpm@linux-foundation.org>
	 <200806071359.04426.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:26092 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141AbYFGObx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2008 10:31:53 -0400
Received: by ug-out-1314.google.com with SMTP id h2so871436ugf.16
        for <linux-acpi@vger.kernel.org>; Sat, 07 Jun 2008 07:31:50 -0700 (PDT)
In-Reply-To: <200806071359.04426.maximlevitsky@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Justin Mattock <justinmattock@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sat, Jun 7, 2008 at 12:59 PM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> I also noticed that in -git volume wheel behaves strangely, it sometimes increases volume
> when I rotate it in direction of decrease, and vise versa.

I have a similar problem, the ACPI keys on my laptop are very laggy
(like 1 second), maybe you are seeing the same thing with your volume
wheel?

changing
 if (atomic_read(&ec->irq_count) > 5) {
 to
if (atomic_read(&ec->irq_count) > 20) {
fixed the problem completely for me.

It's all in http://bugzilla.kernel.org/show_bug.cgi?id=9998

Cheers.

-- 
Guillaume
