From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
Date: Thu, 17 Jan 2019 12:41:19 +0100
Message-ID: <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116175804.30196-6-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Add entries for memory initiator and target node class attributes.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

I would recommend combining this with the previous patch, as the way
it is now I need to look at two patches at the time. :-)

> ---
>  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 3e90e1f3bf0a..a9c47b4b0eee 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -90,4 +90,27 @@ Date:                December 2009
>  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
>  Description:
>                 The node's huge page size control/query attributes.
> -               See Documentation/admin-guide/mm/hugetlbpage.rst
> \ No newline at end of file
> +               See Documentation/admin-guide/mm/hugetlbpage.rst
> +
> +What:          /sys/devices/system/node/nodeX/classY/
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node's relationship to other nodes for access class "Y".
> +
> +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node list of memory initiators that have class "Y" access
> +               to this node's memory. CPUs and other memory initiators in
> +               nodes not in the list accessing this node's memory may have
> +               different performance.

This does not follow the general "one value per file" rule of sysfs (I
know that there are other sysfs files with more than one value in
them, but it is better to follow this rule as long as that makes
sense).

> +
> +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node list of memory targets that this initiator node has
> +               class "Y" access. Memory accesses from this node to nodes not
> +               in this list may have differet performance.
> --

Same here.

And if you follow the recommendation given in the previous message
(add "initiators" and "targets" subdirs under "classX"), you won't
even need the two files above.

And, of course, the symlinks part needs to be documented as well.  I
guess you can follow the
Documentation/ABI/testing/sysfs-devices-power_resources_D0 with that.
