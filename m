From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC tree
Date: Tue, 23 Apr 2019 18:39:47 +0200
Message-ID: <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi Corbet and All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
>
> In this version I combined ACPI and PCI docs, and added new x86 docs conversion.

I'm not sure if combining all three into one big patch series has been
a good idea, honestly.

It would have been easier to review and handle otherwise.

For one, I'd like to handle the ACPI part of it myself if Jon doesn't mind that.

Thanks,
Rafael
