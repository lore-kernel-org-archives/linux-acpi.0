From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] lenovo-sl-laptop : driver for review
Date: Fri, 20 Feb 2009 00:00:33 -0300
Message-ID: <20090220030033.GA18425@khazad-dum.debian.net>
References: <20090216025918.66d7a466@leftboat.lan> <20090216151809.GA4724@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42266 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752256AbZBTDAi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Feb 2009 22:00:38 -0500
Content-Disposition: inline
In-Reply-To: <20090216151809.GA4724@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alexandre Rostovtsev <tetromino@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 16 Feb 2009, Matthew Garrett wrote:
> On Mon, Feb 16, 2009 at 02:59:18AM -0500, Alexandre Rostovtsev wrote:
> > +static struct device_attribute dev_attr_bluetooth_enable =
> > +	__ATTR(bluetooth_enable, S_IWUSR | S_IRUGO,
> > +		bluetooth_enable_show, bluetooth_enable_store);
> 
> You support rfkill, so I'm not sure there's a benefit in exposing the 
> same functionality via a custom sysfs node.

Not only there is no benefit, it won't work at all.  The rfkill core will
set the radio state to match the global state for that radio type during the
rfkill_register() call.

Alexandre,  if the thinkpad-sl can store rfkill state across shutdown in
nvram or something like that, there is an API on the rfkill core that you
can use.  The current thinkpad-acpi code does it, you can use that as an
example.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
