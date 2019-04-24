From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx
 TOC tree
Date: Wed, 24 Apr 2019 13:52:28 -0300
Message-ID: <20190424135228.58cdb9be@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190424101846.7cc4bad7@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424101846.7cc4bad7@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Changbin Du <changbin.du@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 10:18:46 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 24 Apr 2019 00:28:29 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > reST format in this serias.
> > 
> > In this version I combined ACPI and PCI docs, and added new x86 docs conversion.  
> 
> As mentioned by others, this is a lot of stuff; I would really rather see
> each of those groups as separate patch sets.

Yeah, makes sense to me, either to split into separate patchsets or to
group the changes per sub-dir (or both).

> If you can do a reasonably quick turnaround with Mauro's suggestions
> addressed and tags applied, we should be able to get at least some of this
> into 5.2.  Thanks, Mauro, for looking at all of this stuff!

Anytime! Just to make clear, I'm still reviewing it... I'm at patch 35/63
now. So, expect more comments from my side.


Thanks,
Mauro
