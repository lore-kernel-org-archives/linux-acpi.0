From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v2 08/14] genirq: Introduce helper function
 irq_data_get_affinity_mask()
Date: Wed, 20 May 2015 16:50:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505201648490.4225@nanos>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com> <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 May 2015, Jiang Liu wrote:

> Introduce helper function irq_data_get_affinity_mask() and
> irq_get_affinity_mask() to hide implementation details,

That patch does way more than introducing the functions. Again:

Patch 1: Introduce helpers

Patch 2-n: Convert users subsystem wise

Thanks,

	tglx
