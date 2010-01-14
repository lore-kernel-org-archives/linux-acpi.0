From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCHv2] [RFC] firewire: Add ohci1394 PCI runtime power management
 support
Date: Thu, 14 Jan 2010 01:13:43 +0100
Message-ID: <4B4E61B7.9080104@s5r6.in-berlin.de>
References: <4B4E14D7.5080801@s5r6.in-berlin.de> <1263423862-8369-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:57412 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab0ANAOG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2010 19:14:06 -0500
In-Reply-To: <1263423862-8369-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-pm@lists.linux-foundation.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux1394-devel@lists.sourceforge.net

Matthew Garrett wrote:
> it'd be good to have a sanity check on the core change to make sure I'm doing
> the right thing when looking at the selfIDs.

(I still need to look at that part.)

> I've dropped the mdelays - the
> only time I've managed to get the card to take more than a single attempt
> to perform the write was when I wasn't performing the posting read.

This is good news.  Makes it all simpler.  I hope this is true for all
cards out there; we will see.

[...]
> +	unsigned long flags;
> +
> +	spin_lock_bh(&ohci->phy_lock);

A few of those flags variables are unused now.

[...]
> +static int ohci_read_port_reg(struct fw_card *card, int port,
> +			      int addr, u32 *val)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_bh(&ohci->port_lock);
> +	if (ohci_update_phy_reg(card, 7, 0xff, port)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (ohci_read_phy_reg(card, 8+addr, val)) {
[...]

> +static int is_extended_phy(struct fw_card *card)
> +{
> +	u32 val;
> +
> +	if (ohci_read_phy_reg(card, 2, &val))
> +		return -EBUSY;
> +
> +	if ((val & 0xE0) == 0xE0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int ohci_configure_wakeup(struct fw_card *card)
> +{
> +	struct fw_ohci *ohci = fw_ohci(card);
> +	int i, total_ports;
> +	u32 val;
> +
> +	if (ohci_read_phy_reg(card, 2, &val))
> +		return -EBUSY;
> +
> +	total_ports = val & 0x1f;
> +
> +	/* Attempt to enable port interrupts */
> +	for (i = 0; i < total_ports; i++) {
> +		ohci_write_port_reg(card, i, 1, 0, 0x10);
> +		ohci_read_port_reg(card, i, 1, &val);
[...]

BTW, about the curiosity that register 2's Total_ports is 5 bits wide
while register 7's Port_select is only 4 bits wide:

This is apparently because the former was already defined in IEEE
1394-1995 and the latter was added in 1394a-2000.  Furthermore,
1394-1995 specified self ID packets which allowed a PHY to have up to 27
ports.  1394a-2000 redefined the self ID packets so that there can now
only be up to 16 ports per PHY.  So both fields could just be 4 bits
wide since 1394a, but they left the former field as it was.

OHCI 1.0 and OHCI 1.1 require compliant links to be coupled with a PHY
that supports the 1394a PHY register map, which implies no more than 16
ports.  (In practice, there aren't any controllers with more than three
ports at its PHY, so this is hypothetical.)  Nevertheless,
is_extended_phy() could be made super-safe by checking for

	/* 1394a compliant PHY register map, and <= 16 ports */
	if ((val & 0xf0) == 0xe0)
		return 1;

instead.

BTW, as a micro-optimization, the rolled-out contents of

> +	if (is_extended_phy(card)) {
> +		if (ohci_configure_wakeup(card) == 0)
> +			ohci_clear_port_event(card);
> +	}

can be folded into a single function body.  Saves one ohci_read_phy_reg.
-- 
Stefan Richter
-=====-==-=- ---= -===-
http://arcgraph.de/sr/
