From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [patch 2/4]  acpiphp: handle dock bridges
Date: Tue, 17 Jan 2006 22:55:52 -0500
Message-ID: <200601172255.53650.dtor_core@ameritech.net>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:8817 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964904AbWARDz6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 22:55:58 -0500
In-Reply-To: <1137545819.19858.47.camel@whizzy>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz

On Tuesday 17 January 2006 19:56, Kristen Accardi wrote:

> +
> +	down(&slot->crit_sect);
> +	list_for_each(l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);

list_for_each_entry() maybe?

> +static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
> +					struct pci_dev *dev)
> +{
> +	struct list_head *l;
> +	struct acpiphp_func *func;
> +	struct pci_bus *bus = slot->bridge->pci_bus;
> +
> +	list_for_each (l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);

And here?

-- 
Dmitry
