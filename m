From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in
	hardware
Date: Fri, 4 Jul 2008 16:49:50 -0300
Message-ID: <20080704194950.GA27898@khazad-dum.debian.net>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org> <20080704030948.GB31908@khazad-dum.debian.net> <20080704091307.GB8905@srcf.ucam.org> <20080704115519.GA7435@khazad-dum.debian.net> <20080704173910.GA16595@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080704173910.GA16595@srcf.ucam.org>
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org, jesse.barnes@intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 04 Jul 2008, Matthew Garrett wrote:
> Got it. The reason for the delay is that BRTO sits in a loop for no 
> obvious reason unless BRTF is cleared. The only thing that clears BRTF 
> is the PWMS function, which isn't called anywhere in the ACPI tables. 
> The NetBSD driver has the following code:
> 
> 	/* Claim ownership of brightness control */
> 	param[0].Integer.Value = 0;
> 	(void)AcpiEvaluateObject(sc->sc_node->ad_handle, "PWMS", &params, NULL);
> 
> and doing this in thinkpad_acpi means my brightness control works in an 
> acceptably speedy manner with opregion. Henrique, any thoughts on this? 
> If you're happy with it, we can get opregion support into .27 and add 
> the patch to remove duplicate ACPI video devices and everything will 
> work in a beautiful and harmonious manner.

Well done!

Please give me one or two days to check the data I have and look over the
new DSDTs, and I will give you a better reply.

I really should go over the FreeBSD and NetBSD thinkpad drivers with a fine
comb looking over for stuff they figured out about the firmware that
thinkpad-acpi doesn't know about yet.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
