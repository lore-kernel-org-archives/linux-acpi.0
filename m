From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Wed, 31 Dec 2008 11:50:46 +0000
Message-ID: <20081231115046.GA30365@srcf.ucam.org>
References: <200812280611.18320.kel@otaku42.de> <200812291839.47270.kel@otaku42.de> <1230601067.562.235.camel@rzhang-dt> <200812310202.16459.kel@otaku42.de> <1230694408.562.306.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47650 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbYLaLuw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 06:50:52 -0500
Content-Disposition: inline
In-Reply-To: <1230694408.562.306.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Kel Modderman <kel@otaku42.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Dec 31, 2008 at 11:33:28AM +0800, Zhang Rui wrote:
> the ACPI video backlight I/F on your laptop is broken.

It looks pretty easy for us to be able to fix up the lists in this case. 
If it's present on several systems then we probably ought to.
