From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Subject: Re: [ACPI] [PATCH] can we compile ACPI without define CONFIG_PM ?
Date: Fri, 07 May 2004 07:52:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <409BA2B2.8050508@backtobasicsmgmt.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>	 <1083903538.2296.248.camel@dhcppc4> <1083929581.9706.35.camel@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S263582AbUEGOwh@vger.kernel.org>
In-Reply-To: <1083929581.9706.35.camel@darkstar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

S=E9rgio Monteiro Basto wrote:

> 1 - ACPI w/o CONFIG_PM (is not supported)
>=20
> 2 - If accidentally we configure ACPI w/o CONFIG_PM. I tested and
> doesn't power off correctly (at least on one Dell Precision 410).=20

It works on my two server boxes here; ACPI turned on (button, fan,=20
processor, thermal zone and timer options only), but power management=20
not turned on. Both machines properly power off when asked.
