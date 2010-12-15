From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: acpi_battery_init() boot speed
Date: Wed, 15 Dec 2010 03:00:54 -0800
Message-ID: <20101215030054.0aae9e1e@infradead.org>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45043 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab0LOK6U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Dec 2010 05:58:20 -0500
In-Reply-To: <alpine.LFD.2.00.1012150308260.4878@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, 15 Dec 2010 03:13:50 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> Hi Arjan,
> I hoped that the test patch below would help acpi_battery_init()
> on machines where it runs a lot of AML.  I have a lenovo s10-3
> where it was taking 900ms, and this patch seemed to reduce
> it to 600ms.  However, I measured again and it seems to have
> gone _up_ to 1300ms - so perhaps there is some other factor
> determining how long that routine is taking?

that's still a long time (we boot all other drivers including KMS in
0.5 seconds combined)

wonder if this stuff is polling some battery property ?
(like discharge rate or something)

wonder if the code could do just enough to register the device, and
do everything else in the background?

