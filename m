From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: pci-ids: add Lenovo PCI vendor ID
Date: Sun, 15 Jul 2007 18:22:06 -0300
Message-ID: <20070715212206.GI19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <1184422336812-git-send-email-hmh@hmh.eng.br> <469A0A6A.9020208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36172 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110AbXGOVWK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 17:22:10 -0400
Content-Disposition: inline
In-Reply-To: <469A0A6A.9020208@garzik.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sun, 15 Jul 2007, Jeff Garzik wrote:
> Henrique de Moraes Holschuh wrote:
>> thinkpad-acpi wants to differentiate IBM from Lenovo ThinkPads, and the 
>> PCI
>> IDs are the best way to go about it for quirk tables and so on.  Add the
>> missing Lenovo PCI ID to pci_ids.h.
>> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>> Cc: Jeff Garzik <jeff@garzik.org>
>> ---
>>  include/linux/pci_ids.h |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 5b1c999..b5f54ca 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2067,6 +2067,8 @@
>>  #define PCI_DEVICE_ID_ALTIMA_AC9100	0x03ea
>>  #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
>>  +#define PCI_VENDOR_ID_LENOVO		0x17aa
>> +
>>  #define PCI_VENDOR_ID_ARECA		0x17d3
>>  #define PCI_DEVICE_ID_ARECA_1110	0x1110
>
> Not sure why I'm CC'd :)  But of course I have an opinion :)  Usually we 
> don't add these IDs until a driver is actually using them.  Just add it in 
> the patch that starts using it in thinkpad-acpi.

Very well.  I don't usually merge stuff that goes to different subsystems,
but since you implicitly ACK'd it... :-)

I will merge this patch with the next one in the series :)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
