From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 07/63] Documentation: ACPI: move
 DSD-properties-rules.txt to firmware-guide/acpi and covert to reST
Date: Tue, 23 Apr 2019 17:52:31 -0300
Message-ID: <20190423175231.371be9ef@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-8-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-8-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:36 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For the conversion itself:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/DSD-properties-rules.rst}            | 21 +++++++++++--------
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 13 insertions(+), 9 deletions(-)
>  rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)
> 
> diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> similarity index 88%
> rename from Documentation/acpi/DSD-properties-rules.txt
> rename to Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> index 3e4862bdad98..4306f29b6103 100644
> --- a/Documentation/acpi/DSD-properties-rules.txt
> +++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> @@ -1,8 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
>  _DSD Device Properties Usage Rules
> -----------------------------------
> +==================================
>  
>  Properties, Property Sets and Property Subsets
> -----------------------------------------------
> +==============================================
>  
>  The _DSD (Device Specific Data) configuration object, introduced in ACPI 5.1,
>  allows any type of device configuration data to be provided via the ACPI
> @@ -18,7 +21,7 @@ specific type) associated with it.
>  
>  In the ACPI _DSD context it is an element of the sub-package following the
>  generic Device Properties UUID in the _DSD return package as specified in the
> -Device Properties UUID definition document [1].
> +Device Properties UUID definition document [1]_.
>  
>  It also may be regarded as the definition of a key and the associated data type
>  that can be returned by _DSD in the Device Properties UUID sub-package for a
> @@ -33,14 +36,14 @@ Property subsets are nested collections of properties.  Each of them is
>  associated with an additional key (name) allowing the subset to be referred
>  to as a whole (and to be treated as a separate entity).  The canonical
>  representation of property subsets is via the mechanism specified in the
> -Hierarchical Properties Extension UUID definition document [2].
> +Hierarchical Properties Extension UUID definition document [2]_.
>  
>  Property sets may be hierarchical.  That is, a property set may contain
>  multiple property subsets that each may contain property subsets of its
>  own and so on.
>  
>  General Validity Rule for Property Sets
> ----------------------------------------
> +=======================================
>  
>  Valid property sets must follow the guidance given by the Device Properties UUID
>  definition document [1].
> @@ -73,7 +76,7 @@ suitable for the ACPI environment and consequently they cannot belong to a valid
>  property set.
>  
>  Property Sets and Device Tree Bindings
> ---------------------------------------
> +======================================
>  
>  It often is useful to make _DSD return property sets that follow Device Tree
>  bindings.
> @@ -91,7 +94,7 @@ expected to automatically work in the ACPI environment regardless of their
>  contents.
>  
>  References
> -----------
> +==========
>  
> -[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> -[2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
> +.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> +.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index 868bd25a3398..0e05b843521c 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -10,3 +10,4 @@ ACPI Support
>     namespace
>     enumeration
>     osi
> +   DSD-properties-rules



Thanks,
Mauro
