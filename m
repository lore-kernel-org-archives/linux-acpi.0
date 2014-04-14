From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/5] x86: fix list corruption on CPU hotplug
Date: Mon, 14 Apr 2014 11:19:54 +0200
Message-ID: <20140414091954.GB19771@gmail.com>
References: <1397150061-29735-1-git-send-email-imammedo@redhat.com>
 <1397150061-29735-4-git-send-email-imammedo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397150061-29735-4-git-send-email-imammedo@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, toshi.kani@hp.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Igor Mammedov <imammedo@redhat.com> wrote:

> currently if AP wake up is failed, master CPU marks AP as not present
> in do_boot_cpu() by calling set_cpu_present(cpu, false).
> That leads to following list corruption on the next physical CPU
> hotplug:

Shouldn't this fix precede the main change to the smp bootup logic?

Can this bug trigger with current upstream kernels?

Thanks,

	Ingo
