From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v5 4/4] x86: initialize secondary CPU only if master CPU
 will wait for it
Date: Mon, 05 May 2014 15:35:10 -0600
Message-ID: <1399325710.1789.95.camel@misato.fc.hp.com>
References: <1399322991-19329-1-git-send-email-imammedo@redhat.com>
	 <1399322991-19329-5-git-send-email-imammedo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399322991-19329-5-git-send-email-imammedo@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2014-05-05 at 22:49 +0200, Igor Mammedov wrote:
> Hang is observed on virtual machines during CPU hotplug,
> especially in big guests with many CPUs. (It reproducible
> more often if host is over-committed).
> 
> It happens because master CPU gives up waiting on
> secondary CPU and allows it to run wild. As result
> AP causes locking or crashing system. For example
> as described here: https://lkml.org/lkml/2014/3/6/257
> 
> If master CPU have sent STARTUP IPI successfully,
> and AP signalled to master CPU that it's ready
> to start initialization, make master CPU wait
> indefinitely till AP is onlined.
> To ensure that AP won't ever run wild, make it
> wait at early startup till master CPU confirms its
> intention to wait for AP. If AP doesn't respond in 10
> seconds, the master CPU will timeout and cancel
> AP onlining.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Thanks for the update.

Acked-by: Toshi Kani <toshi.kani@hp.com>

-Toshi
