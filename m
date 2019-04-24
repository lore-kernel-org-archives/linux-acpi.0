From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v5 14/23] Documentation: ACPI: move
 dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 15:10:20 -0300
Message-ID: <20190424151020.406b81ef@coco.lan>
References: <20190424175306.25880-1-changbin.du@gmail.com>
        <20190424175306.25880-15-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424175306.25880-15-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Thu, 25 Apr 2019 01:52:57 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsd/data-node-references.rst}        | 36 ++++++++++---------
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 21 insertions(+), 16 deletions(-)
>  rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)
> 
> diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> similarity index 71%
> rename from Documentation/acpi/dsd/data-node-references.txt
> rename to Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> index c3871565c8cf..1351984e767c 100644
> --- a/Documentation/acpi/dsd/data-node-references.txt
> +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> @@ -1,9 +1,12 @@
> -Copyright (C) 2018 Intel Corporation
> -Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> -
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> +===================================
>  Referencing hierarchical data nodes
> ------------------------------------
> +===================================
> +
> +:Copyright: |copy| 2018 Intel Corporation
> +:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
>  
>  ACPI in general allows referring to device objects in the tree only.
>  Hierarchical data extension nodes may not be referred to directly, hence this
> @@ -28,13 +31,14 @@ extension key.
>  
>  
>  Example
> --------
> +=======
>  
> -	In the ASL snippet below, the "reference" _DSD property [2] contains a
> -	device object reference to DEV0 and under that device object, a
> -	hierarchical data extension key "node@1" referring to the NOD1 object
> -	and lastly, a hierarchical data extension key "anothernode" referring to
> -	the ANOD object which is also the final target node of the reference.
> +In the ASL snippet below, the "reference" _DSD property [2] contains a
> +device object reference to DEV0 and under that device object, a
> +hierarchical data extension key "node@1" referring to the NOD1 object
> +and lastly, a hierarchical data extension key "anothernode" referring to
> +the ANOD object which is also the final target node of the reference.
> +::
>  
>  	Device (DEV0)
>  	{
> @@ -75,15 +79,15 @@ Example
>  	    })
>  	}
>  
> -Please also see a graph example in graph.txt .
> +Please also see a graph example in :doc:`graph`.
>  
>  References
> -----------
> +==========
>  
>  [1] Hierarchical Data Extension UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
> -    referenced 2018-07-17.
> +<http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
> +referenced 2018-07-17.
>  
>  [2] Device Properties UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
> -    referenced 2016-10-04.
> +<http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
> +referenced 2016-10-04.
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index f81cfbcb6878..6d4e0df4f063 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -9,6 +9,7 @@ ACPI Support
>  
>     namespace
>     dsd/graph
> +   dsd/data-node-references
>     enumeration
>     osi
>     method-customizing



Thanks,
Mauro
