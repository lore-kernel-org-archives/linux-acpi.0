From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx
 TOC tree
Date: Wed, 24 Apr 2019 10:18:46 -0600
Message-ID: <20190424101846.7cc4bad7@lwn.net>
References: <20190423162932.21428-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 24 Apr 2019 00:28:29 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
> 
> In this version I combined ACPI and PCI docs, and added new x86 docs conversion.

As mentioned by others, this is a lot of stuff; I would really rather see
each of those groups as separate patch sets.

If you can do a reasonably quick turnaround with Mauro's suggestions
addressed and tags applied, we should be able to get at least some of this
into 5.2.  Thanks, Mauro, for looking at all of this stuff!

Thanks,

jon
