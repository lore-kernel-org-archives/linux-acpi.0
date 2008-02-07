From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH][drivers/misc/thinkpad_acpi.c] duplicate test
	if (level & TP_EC_FAN_FULLSPEED)
Date: Wed, 6 Feb 2008 21:55:07 -0800
Message-ID: <20080207055507.GA7212@kroah.com>
References: <47A78CBB.2090401@tiscali.nl> <ada8x20gykq.fsf@cisco.com> <47A79EC8.6060700@tiscali.nl> <20080205050504.GB30670@khazad-dum.debian.net> <47A81FAE.2090709@tiscali.nl> <20080206230702.GA12395@kroah.com> <47AA4748.3040702@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:45656 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYBGGDs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 01:03:48 -0500
Content-Disposition: inline
In-Reply-To: <47AA4748.3040702@tiscali.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: len.brown@intel.com, ibm-acpi-devel@lists.sourceforge.net, Roland Dreier <rdreier@cisco.com>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org

On Thu, Feb 07, 2008 at 12:48:24AM +0100, Roel Kluin wrote:
> Greg KH wrote:
> > On Tue, Feb 05, 2008 at 09:34:54AM +0100, Roel Kluin wrote:
> >> Henrique de Moraes Holschuh wrote:
> >>> On Tue, 05 Feb 2008, Roel Kluin wrote:
> >>>> Roland Dreier wrote:
> 
> >>>>>  > Note the duplicate test 'if (level & TP_EC_FAN_FULLSPEED)'. should
> >>>>>  > this be replaced by
> >>>>>
> >>>>> Actually I suspect one of the two tests should be against TP_EC_FAN_AUTO
> >>>>> (based on the comment).
> >>>> Thanks Roland, for your info
> 
> >>> ACK.  This needs to be sent to stable as well.  I think both 2.6.22 and
> >>> 2.6.23 need this patch.
> >>>
> >> CC stable@kernel.org
> > 
> > Please send us a real copy of the patch, when it goes into Linus's tree,
> > so we know what to apply, and that it is safe to do so.
> 
> It's a oneliner and the patch is from linus' tree.
> ---
> in commit eaa7571b2d1a08873e4bdd8e6db3431df61cd9ad, a safety net for TPEC
> fan control mode was added. Quoting that patch:

I don't see this patch in Linus's tree, I see the patch you are
patching, but not this one :)

Can you tell me the git id of the patch you wish to go into the stable
tree, and send the whole thing to us?

thanks,

greg k-h
