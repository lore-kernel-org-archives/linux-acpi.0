From: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] x86/ioapic: Ignore root bridges without a companion ACPI
 device
Date: Mon, 12 Sep 2016 15:25:38 -0600
Message-ID: <20160912212537.GA1740@localhost.localdomain>
References: <1473522046-31329-1-git-send-email-rui.y.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754866AbcILVZk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 17:25:40 -0400
Content-Disposition: inline
In-Reply-To: <1473522046-31329-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rui Wang <rui.y.wang@intel.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, rjw@rjwysocki.net, mingo@kernel.org, bp@alien8.de, torvalds@linux-foundation.org, peterz@infradead.org, helgaas@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org

On Sat, Sep 10, 2016 at 11:40:45PM +0800, Rui Wang wrote:
> Some PCI root bridges don't have a corresponding ACPI device.
> This can be the case on some old platforms. Don't call acpi_ioapic_add()
> on these bridges because they can't support ioapic hotplug.
Not just old platforms. VMD is a new device which initializes a root port in software without an acpi handle.

What branch is this based on? I can't find the relevant code/commits
