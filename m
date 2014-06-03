From: David Rientjes <rientjes@google.com>
Subject: Re: [Patch V3 03/37] x86, mpparse: use pr_lvl() helper utilities to
 replace printk(KERN_LVL)
Date: Mon, 2 Jun 2014 17:41:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406021740100.11822@chino.kir.corp.google.com>
References: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com> <1401178092-1228-4-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1401178092-1228-4-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 May 2014, Jiang Liu wrote:

> Use pr_lvl() helper utilities to replace printk(KERN_LVL) for readability,
> no function changes.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: David Rientjes <rientjes@google.com>

Eek, lots of newlines in single printks without pr_cont() that are 
existing, probably to make them more visible during debugging.  I think we 
could clean this up even further, but the printk(KERN_LVL) -> pr_lvl() 
conversion of this patch is a step in the right direction.
