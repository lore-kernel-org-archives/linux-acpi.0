From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2] eeepc-laptop: Use standard interfaces
Date: Mon, 4 Aug 2008 18:29:52 -0300
Message-ID: <20080804212952.GC24927@khazad-dum.debian.net>
References: <20080804170833.GA9513@srcf.ucam.org> <20080804171504.GB9513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56486 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763145AbYHDV35 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 17:29:57 -0400
Content-Disposition: inline
In-Reply-To: <20080804171504.GB9513@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corentincj@iksaif.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, IvDoorn@gmail.com

On Mon, 04 Aug 2008, Matthew Garrett wrote:
> +static int eeepc_wlan_rfkill_set(void *data, enum rfkill_state state)
> +{
> +	return set_acpi(CM_ASL_WLAN, state);
> +}
> +
> +static int eeepc_wlan_rfkill_state(void *data, enum rfkill_state *state)
> +{
> +	*state = get_acpi(CM_ASL_WLAN);
> +	return 0;
> +}

This might just be style, but I'd rather you didn't do this unless get_acpi
and set_acpi do take enum rfkill_state...  Doing state conversion would be a
lot more future-proof, as well:

Something like:
	set_acpi(CM_ASL_WLAN, (state == RFKILL_STATE_UNBLOCKED) ? 0 : 1);

And:

	*state = get_acpi(CM_ASL_WLAN) ? RFKILL_STATE_SOFT_BLOCKED :
						RFKILL_STATE_UNBLOCKED;

Adjust as needed.

> +		ehotk->eeepc_wlan_rfkill->user_claim_unsupported = 0;

This is not needed, and if we get rid of user_claim_unsupported later, your
code wouldn't need changes if you get rid of that line.

I have not paid much attention to it yet, but so far I have failed to
understand what user_claim_unsupported is good for in the new style rfkill
interface.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
