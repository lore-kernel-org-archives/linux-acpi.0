From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Patch v3 2/2] x86/acpi: Remove the repeated lapic address
 override entry parsing
Date: Wed, 10 Aug 2016 16:02:57 +0200
Message-ID: <20160810140257.GB22965@gmail.com>
References: <1469877001-18393-1-git-send-email-bhe@redhat.com>
 <1469877001-18393-2-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469877001-18393-2-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> ACPI MADT has a 32-bit field providing lapic address at which
> each processor can access its lapic information. MADT also contains
> an optional entry to provide a 64-bit address to override the 32-bit
> one. However the current code does the lapic address override entry
> parsing twice. One is in early_acpi_boot_init() because AMD NUMA need
> get boot_cpu_id earlier. The other is in acpi_boot_init() which parses
> all MADT entries.
> 
> So in this patch remove the repeated code in the 2nd part. Meanwhile
> print lapic override entry information like other MADT entry, this
> will be added to boot log.

it is not at all clear to me from this changelog whether the change is supposed to 
change anything. If not then please spell it out explicitly:

  "This patch is not supposed to change any behavior."

Or so.

Thanks,

	Ingo
