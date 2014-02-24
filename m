From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] ipmi: Cleanups for allowing IPMI support to always be "y"
Date: Mon, 24 Feb 2014 13:43:14 +0100
Message-ID: <3293311.NLXg2udD5E@vostro.rjw.lan>
References: <1393208616-16500-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393208616-16500-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Russ Anderson <rja@sgi.com>, Matthew Garrett <matthew.garrett@nebula.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, February 23, 2014 08:23:33 PM minyard@acm.org wrote:
> Three patches to remove issues with probing interface default, to make
> sure the driver is completely idle if nothing is happening on it, and to
> compile the IPMI driver into the kernel if ACPI is enabled.
> 
> The ACPI spec really requires that the IPMI driver be built into the
> kernel because ACPI uses IPMI for some operations.  But some people
> do not want the driver even using the mimimal amount of CPU it uses
> when idle.  And the default probing, even though sort of implied to
> be required by the spec, is really a bad idea and can result in hangs
> on systems with other hardware at those location.
> 
> Hopefully these patches make everyone happy.

No objections from my side.

I'll drop the Matthew's patch ([3/3] in this series) from my tree, then, so
please carry it along will any followups if needed.

Thanks,
Rafael
