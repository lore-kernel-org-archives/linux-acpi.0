From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Patch v7 17/18] x86, irq: Introduce helper to check whether an
 IOAPIC has been registered
Date: Tue, 28 Oct 2014 18:47:22 +0100
Message-ID: <20141028174722.GB9134@amd>
References: <1414387308-27148-1-git-send-email-jiang.liu@linux.intel.com>
 <1414387308-27148-18-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414387308-27148-18-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Len Brown <len.brown@intel.com>, Grant Likely <grant.likely@linaro.org>, Prarit Bhargava <prarit@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon 2014-10-27 13:21:47, Jiang Liu wrote:
> Introduce acpi_ioapic_registered() to check whether an IOAPIC has already
> been registered, it will be used when enabling IOAPIC hotplug.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Nothing obviously wrong.

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
