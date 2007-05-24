From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Thu, 24 May 2007 23:01:53 +0200
Message-ID: <20070524210153.GB19672@elte.hu>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524125453.GA7554@elte.hu> <E1HrDuQ-0005m7-00@dorka.pomaz.szeredi.hu> <20070524141059.GA19872@elte.hu> <E1HrEIp-0005qy-00@dorka.pomaz.szeredi.hu> <20070524144447.GA25068@elte.hu> <E1HrGom-0006AC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38949 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbXEXVCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 May 2007 17:02:00 -0400
Content-Disposition: inline
In-Reply-To: <E1HrGom-0006AC-00@dorka.pomaz.szeredi.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> 2.6.22-rc2, only EVENT_TRACE - boots, can't rerpoduce
> 2.6.21-vanila - can reproduce
> 2.6.21-rt7, trace options off - can reproduce
> 2.6.21-rt7, trace options on - can't reproduce
> 
> Possibly something timing related, that's altered by the trace code. I 
> tried the trace kernel without starting the trace app, but still no 
> bug.
> 
> Any other ideas?

perhaps try 2.6.21-rt7 with EVENT_TRACE on (the other trace options off) 
- does that hide the bug too?

	Ingo
