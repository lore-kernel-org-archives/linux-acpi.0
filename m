From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs
 attributes
Date: Fri, 18 Jan 2019 11:21:34 +0000
Message-ID: <20190118112134.00003b65@huawei.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
        <20190116175804.30196-6-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116175804.30196-6-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 16 Jan 2019 10:57:56 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Add entries for memory initiator and target node class attributes.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 3e90e1f3bf0a..a9c47b4b0eee 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -90,4 +90,27 @@ Date:		December 2009
>  Contact:	Lee Schermerhorn <lee.schermerhorn@hp.com>
>  Description:
>  		The node's huge page size control/query attributes.
> -		See Documentation/admin-guide/mm/hugetlbpage.rst
> \ No newline at end of file
> +		See Documentation/admin-guide/mm/hugetlbpage.rst
> +
> +What:		/sys/devices/system/node/nodeX/classY/
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The node's relationship to other nodes for access class "Y".
> +
> +What:		/sys/devices/system/node/nodeX/classY/initiator_nodelist
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The node list of memory initiators that have class "Y" access
> +		to this node's memory. CPUs and other memory initiators in
> +		nodes not in the list accessing this node's memory may have
> +		different performance.
> +
> +What:		/sys/devices/system/node/nodeX/classY/target_nodelist
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The node list of memory targets that this initiator node has
> +		class "Y" access. Memory accesses from this node to nodes not
> +		in this list may have differet performance.

Different performance from what?  In the other thread we established that
these target_nodelists are kind of a backwards reference, they all have
their characteristics anyway.  Perhaps this just needs to say:
"Memory access from this node to these targets may have different performance"?

i.e. Don't make the assumption I did that they should all be the same!
