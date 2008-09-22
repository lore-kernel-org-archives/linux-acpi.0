From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 10:08:50 +0100
Message-ID: <48D760A2.3030007@tuffmail.co.uk>
References: <48D695B3.5000303@tuffmail.co.uk> <48D69DC9.5060100@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:9299 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbYIVJI6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 05:08:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so453928nfc.21
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2008 02:08:56 -0700 (PDT)
In-Reply-To: <48D69DC9.5060100@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Alexey Starikovskiy wrote:
> Hi Alan,
> That patch is old news already...
> There is a new shiny one appended to 9998/10724/11549...
> Please give it a try. It does disable GPE, but for very small duration.

Ok.  I was put off by the noise :-).

I've just tested 2.6.27-rc6 with
<http://bugzilla.kernel.org/show_bug.cgi?id=9998#c81>.  It still "drops"
some events, but now it takes longer to happen.  I have to work much
harder bashing the keys to reproduce it.


Like before, missing an event has severe consequences.  The missed event
is buffered.  When a new event occurs, only the oldest event is removed
from the buffer.  Therefore the buffer can only grow.  Eventually,
something breaks.  Events stop being delivered altogether; presumably
the buffer overflows.  I confirmed that this does still happen.

Remember that these are the consequences of a specific EC bug.  On my
EC, querying an event always clears SCI_EVT, even if there are more
events pending.  It is only re-raised when a new event fires.


I'll try reading the patch.  I may try capturing an EC debug log to show
how the event is dropped, but that will take time.

Thanks
Alan
