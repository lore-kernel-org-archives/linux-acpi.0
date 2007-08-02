From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ACPI on Averatec 2370
Date: Thu, 02 Aug 2007 15:09:14 -0400
Message-ID: <46B22BDA.8090604@redhat.com>
References: <5ebbd9b50707291105w316f98e5h3fa17204c9119a2f@mail.gmail.com> <46ACD8DB.2020108@googlemail.com> <Pine.LNX.4.64.0707301048460.5693@lancer.cnet.absolutedigital.net> <Pine.LNX.4.64.0708021335060.28012@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978AbXHBTKI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Aug 2007 15:10:08 -0400
In-Reply-To: <Pine.LNX.4.64.0708021335060.28012@lancer.cnet.absolutedigital.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cal Peake <cp@absolutedigital.net>
Cc: Gabriel C <nix.or.die@googlemail.com>, Frank Hale <frankhale@gmail.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel ACPI Mailing List <linux-acpi@vger.kernel.org>, len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 08/02/2007 01:50 PM, Cal Peake wrote:
> This problem seems to be getting worse. With the latest linus tree, after 
> the initial hang where the power button is needed to bring the system back 
> to life, the boot process slows to a crawl.
> 
> Although if I repeatedly press the shift key it'll help move things along. 
> I'm guessing the keyboard interrupt firing off is doing something to help 
> it. The system seems OK though after booting is finished.
> 
> Upon shutdown it actually stalls out without help from the shift key.
> 
> Any thoughts on this, or tips to help debug it further?

Try the 'nolapic_timer' option.
