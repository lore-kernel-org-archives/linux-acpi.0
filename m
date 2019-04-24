From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 37/63] Documentation: add Linux x86 docs to Sphinx
 TOC tree
Date: Wed, 24 Apr 2019 14:04:24 -0300
Message-ID: <20190424140424.72d5ae56@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-38-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-38-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:29:06 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Add a index.rst for x86 support. More docs will be added later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/index.rst     | 1 +
>  Documentation/x86/index.rst | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/x86/index.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index d80138284e0f..f185c8040fa9 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -112,6 +112,7 @@ implementation.
>  .. toctree::
>     :maxdepth: 2
>  
> +   x86/index
>     sh/index
>  
>  Filesystem Documentation
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> new file mode 100644
> index 000000000000..7612d3142b2a
> --- /dev/null
> +++ b/Documentation/x86/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Linux x86 Support
> +=================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:

Looks ok to me:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Just one reminder: after merging both this and my conversions, we may
need to do some review at the architecture titles, in order to
make them consistent. 

On mu conversion patches, I'm using

	==================
	$arch Architecture
	==================

Probably also not the best title. Anyway, this can easily be fixed
with a follow up patch once we get everything merged.

Thanks,
Mauro
