From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH] ACPI: EC: Don't trust ECDT tables from ASUS
Date: Tue, 02 Dec 2008 20:13:00 +0300
Message-ID: <49356C9C.4050907@suse.de>
References: <20081201204706.32465.23231.stgit@thinkpad> <1228205657.4035.206.camel@yakui_zhao.sh.intel.com> <49350201.9010601@suse.de> <20081202155228.GI1668@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:44994 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810AbYLBRNA (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 2 Dec 2008 12:13:00 -0500
In-Reply-To: <20081202155228.GI1668@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Henrique de Moraes Holschuh wrote:
> On Tue, 02 Dec 2008, Alexey Starikovskiy wrote:
>> ASUSTek keeps feeding us with broken ECDT tables, which are very hard to workaround.
>> So, we end up always checking that ECDT from ASUS has the same info as DSDT, and
>> bark otherwise.
> 
> I wish we would do more of that, AND printk "BIOS BUG" and "FIRMWARE BUG"
> everytime we activate any quirk or bug due to something we are completely
> sure to be a vendor firmware screw-up.
I've talked to several Taiwanese notebook BIOS writers lately, and they all seem to
know only one thing -- if Windows boots, BIOS is ok. So we might write huge banners in
neon letters -- it will not work...
> 
> Otherwise, the situation never seems to get better :(
> 

