From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 5/7] doc/vm: New documentation for memory cache
Date: Wed, 14 Nov 2018 16:41:35 -0800
Message-ID: <c86b7a76-fff1-0b15-163f-75bdf732ce6a@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-6-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114224921.12123-6-keith.busch@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 11/14/18 2:49 PM, Keith Busch wrote:
> +	# tree sys/devices/system/node/node0/cache/
> +	/sys/devices/system/node/node0/cache/
> +	|-- index1
> +	|   |-- associativity
> +	|   |-- level
> +	|   |-- line_size
> +	|   |-- size
> +	|   `-- write_policy

Whoops, and here it is...
