From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 23:25:51 +0000
Message-ID: <20070314232550.GA11970@srcf.ucam.org>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org> <45F806B1.3060807@elevating.com> <20070314143534.GA2655@srcf.ucam.org> <45F80EAA.6010808@elevating.com> <20070314151441.GA3396@srcf.ucam.org> <45F817E2.1020900@elevating.com> <45F84103.8050803@elevating.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:35225 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXCNX0H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2007 19:26:07 -0400
Content-Disposition: inline
In-Reply-To: <45F84103.8050803@elevating.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bret Hughes <bhughes@elevating.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Mar 14, 2007 at 01:37:55PM -0500, Bret Hughes wrote:

> Woo hoo! I see my device it's id is TKO0001 just like the engr told me 
> it would be.  At the time I had little to no idea what he was talking about.
> 
> On to look at the code and see how that works.

Something like the following should work, if you haven't already got it 
figured:

diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
index d3d6b82..c7b019b 100644
--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -340,6 +340,8 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{       "FUJ02B8",              0 },
 	{       "FUJ02B9",              0 },
 	{       "FUJ02BC",              0 },
+	/* TouchKO touchscreen */
+	{       "TKO0001",              0 },
 	/* Rockwell's (PORALiNK) 33600 INT PNP */
 	{	"WCI0003",		0	},
 	/* Unkown PnP modems */

and then just make sure that you have CONFIG_8250_PNP enabled. After 
that, it should just appear as a touchscreen. You may still need to 
perform some handshaking in the protocol interaction to get it working, 
but ideally that would be done in the X driver.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
