From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC
 tree
Date: Wed, 24 Apr 2019 12:03:43 -0300
Message-ID: <20190424120336.4f66cbb8@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-26-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-26-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:54 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Add a index.rst for PCI subsystem. More docs will be added later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst | 9 +++++++++

On a past discussion at docs ML, we've agreed to use lowercase for new
stuff. My suggestion here would be to use lowercase for "pci".

Also, there's already a pci directory under driver-api, added on this
commit:

	commit fcc78f9c22474d60c65d522e50ea07006ec1b9fc
	Author: Logan Gunthorpe <logang@deltatee.com>
	Date:   Thu Oct 4 15:27:39 2018 -0600

	    docs-rst: Add a new directory for PCI documentation

I would just add a new section at Documentation/driver-api/pci/index.rst
with something like:

	Legacy PCI documentation
	========================

	.. note::

	   The files here were written a long time ago and need some serious
	   work. Use their contents with caution.

	.. toctree::
	    :maxdepth: 1

	    <files converted from Documentation/PCI>

And add those documents from Documentation/PCI into it.

>  Documentation/index.rst     | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/PCI/index.rst
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> new file mode 100644
> index 000000000000..c2f8728d11cf
> --- /dev/null
> +++ b/Documentation/PCI/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Linux PCI Bus Subsystem
> +=======================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index fdfa85c56a50..d80138284e0f 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -100,6 +100,7 @@ needed).
>     filesystems/index
>     vm/index
>     bpf/index
> +   PCI/index
>     misc-devices/index
>  
>  Architecture-specific documentation



Thanks,
Mauro
