From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 18:08:39 +0000
Message-ID: <20091209180839.GK9018@sirena.org.uk>
References: <20091209164653.GI9018@sirena.org.uk> <Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34931 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbZLISIg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 13:08:36 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed, Dec 09, 2009 at 12:10:03PM -0500, Alan Stern wrote:
> On Wed, 9 Dec 2009, Mark Brown wrote:

> > Worst case is about a second for both resume and suspend which means two
> > seconds total but it's very hardware dependant.  

> A second seems awfully long.  What happens if audio isn't being played
> when the suspend occurs?  Can't you shorten things with no artifacts in
> that case?

For the affected hardware the problem is basically the same with or
without audio being played.  As I said in my reply to Linus this is
delays caused by ramping reference voltages.  These delays are
sufficiently long that the reference voltages have to be maintained all
the time so that they don't delay the start of audio streams which means
that having or not having an audio stream at suspend time doesn't affect
the reference voltage ramps since we don't turn them off when not in
use.  There is a win from other stuff having been shut off already, but
it's already being exploited.

On suspend the problem is the same as for resume - we need to ramp the
voltages quietly, this time down to zero.  We want to make sure they're
actually at zero to ensure that the ramp at resume time starts from a
known hardware state.
