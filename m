From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop: don't touch the pci slot if it was claimed
	by a different driver
Date: Mon, 29 Jun 2009 22:03:53 +0200
Message-ID: <71cd59b00906291303u4d7d3c6p278a719b3d5ce02f@mail.gmail.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
	 <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
	 <9b2b86520906290544g2f5d1da9m8539a5a6f67cf33c@mail.gmail.com>
	 <4A48C15C.3000509@tuffmail.co.uk>
	 <20090629192206.GA7811@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39740 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZF2UDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2009 16:03:53 -0400
Received: by fxm18 with SMTP id 18so1205321fxm.37
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2009 13:03:56 -0700 (PDT)
In-Reply-To: <20090629192206.GA7811@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>

On Mon, Jun 29, 2009 at 9:22 PM, Matthew Garrett<mjg59@srcf.ucam.org> w=
rote:
> On Mon, Jun 29, 2009 at 02:27:56PM +0100, Alan Jenkins wrote:
>> The whole point of registering as a PCI hotplug driver was to preven=
t
>> conflict with pciehp. =A0At the moment it happens to work because
>> eeepc-laptop is loaded first, but it doesn't work the other way roun=
d.
>> If pciehp is loaded first then we fail to claim the slot - we need t=
o
>> respect this and not handle hotplug events.
>>
>> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>

> IMO this is not an urgent patch - it's not a regression from 2.6.30.
> Given the number of other changes, I'd be happier if it could be held
> back for 2.6.32.

Merged into ACPI4Asus, while waiting 2.6.32.
Thanks

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
