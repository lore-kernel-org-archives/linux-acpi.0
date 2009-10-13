From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] vsprintf: add %pR decoding and %pr for raw
 struct resource
Date: Tue, 13 Oct 2009 12:40:08 -0700
Message-ID: <1255462808.18975.70.camel@Joe-Laptop.home>
References: <20091013192040.22336.84876.stgit@bob.kio>
	 <20091013192210.22336.28703.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:2101 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934178AbZJMTkp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Oct 2009 15:40:45 -0400
In-Reply-To: <20091013192210.22336.28703.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, Len Brown <lenb@kernel.org>

On Tue, 2009-10-13 at 13:22 -0600, Bjorn Helgaas wrote:
> This adds support for printing struct resource type and flag information.
> For example, "%pR" looks like "[mem 0xf5df0000-0xf5df3fff 64bit pref]",
> and "%pr" looks like "[mem 0xff5e2000-0xff5e2007 flags 0x201]".

%p[A-Za-z0-9] is a relatively limited resource.

Isn't it better to avoid using multiple characters
for a single type?


