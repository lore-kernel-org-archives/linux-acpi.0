From: Prarit Bhargava <prarit@sgi.com>
Subject: Re: [patch 1/3] acpi: dock driver
Date: Sat, 15 Apr 2006 10:29:52 -0400
Message-ID: <44410360.6090003@sgi.com>
References: <20060412221027.472109000@intel.com>	 <1144880322.11215.44.camel@whizzy>  <20060412222735.38aa0f58.akpm@osdl.org> <1145054985.29319.51.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:3002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030269AbWDOOas (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Apr 2006 10:30:48 -0400
In-Reply-To: <1145054985.29319.51.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, mochel@linux.intel.com, arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru


> +static struct dock_dependent_device * alloc_dock_dependent_device(acpi_handle handle)
> +{
> +	struct dock_dependent_device *dd;
> +
> +	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
> +	if (dd) {
> +		dd->handle = handle;
> +		INIT_LIST_HEAD(&dd->list);
> +		INIT_LIST_HEAD(&dd->hotplug_list);
> +	}
> +	return dd;
> +}
> +

Er ... what happens if dd isn't alloc'd?  It looks like the rest of the 
code assumes that dd is a valid pointer ...

P.
