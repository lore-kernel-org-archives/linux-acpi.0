Return-Path: <SRS0=I7UC=XB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE4C43331
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Sep 2019 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343C7208C3
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Sep 2019 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395325AbfIFSPL (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:15:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40930 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730540AbfIFSPL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 14:15:11 -0400
Received: (qmail 4808 invoked by uid 2102); 6 Sep 2019 14:15:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2019 14:15:10 -0400
Date:   Fri, 6 Sep 2019 14:15:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Charles.Hyde@dellteam.com
cc:     bjorn@mork.no, <oliver@neukum.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <Mario.Limonciello@dell.com>,
        <chip.programmer@gmail.com>, <nic_swsd@realtek.com>,
        <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
In-Reply-To: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
Message-ID: <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 6 Sep 2019 Charles.Hyde@dellteam.com wrote:

> <snipped> 
> > > +	ret = usbnet_read_cmd(dev, USB_CDC_GET_NET_ADDRESS,
> > > +			      USB_DIR_IN | USB_TYPE_CLASS
> > > +			      | USB_RECIP_INTERFACE, 0,
> > > +			      USB_REQ_SET_ADDRESS, buf, ETH_ALEN);
> > 
> > Where did that USB_REQ_SET_ADDRESS come from? Did you just look up an
> > arbutrary macro that happened to match your device config?  How do you
> > expect this to work with a generic NCM device?  Or even your own device,
> > when the next firmware revision moves the function to a different interface?
> <snipped>
> 
> https://wiki.osdev.org/Universal_Serial_Bus#SET_ADDRESS
> 
> https://www.usb.org/document-library/network-control-model-devices-specification-v10-and-errata-and-adopters-agreement
> Download and view the NCM specification v1.0 (Errata 1), dated November 24, 2010.  See table 6.2 on page 30.  Also see sections 6.2.2 and 6.2.3 on page 32.
> 
> USB_REQ_SET_ADDRESS came from include/uapi/linux/usb/ch9.h.  This matches the SET_ADDRESS definition from the osdev wiki page, so I used it because the name and numeric values both matched.  It further matches what the Windows driver issues.

The names and values may match, but the meanings do not.  
USB_REQ_SET_ADDRESS refers to a USB bus address, not a MAC address.

Alan Stern

