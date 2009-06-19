From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] dell-wmi Switch support and Tablet switch definition
Date: Fri, 19 Jun 2009 16:31:59 -0400
Message-ID: <4A3BF5BF.5030102@seas.upenn.edu>
References: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu> <20090619140228.GA21354@srcf.ucam.org> <4A3BE6F0.7090107@seas.upenn.edu> <20090619194009.GA28382@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:56536 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZFSUcB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 16:32:01 -0400
In-Reply-To: <20090619194009.GA28382@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matthew Garrett wrote:
> On Fri, Jun 19, 2009 at 03:28:48PM -0400, Rafi Rubin wrote:
> 
>> I agree polling the tablet state would be a good thing.  But that does not mean we should not
>> support the signals until we are ready to support polling.
>>
>> If you are suggesting that we should not use an EV_SW because we will eventually poll the hardware
>> instead of keeping the state in software, then I have no problem with sending keys or other events.
> 
> No, my point is that there's little benefit in providing EV_SW if the 
> initial value is going to be wrong. Software simply can't depend on it. 
> The code's absolutely fine, but there's a risk that it'll break 
> otherwise working desktops until we know how to set the initial value.


The signal is not a toggle.  Its an explicit "going to tablet" and "coming from tablet".  And the
initial value is "non-tablet" mode, which is what must be assumed without this support.

So the only new case where a wrong assumption may be made is if the screen is flipped out of tablet
mode during suspend or hibernate.  But we _don't_ have the potential of a toggle being inverted and
it rotating the screen to something silly every time you flip it.

I think the benefits of the partial support far outweight the potential hazards.


That being said, if you have any clue how to probe the state, I would be very happy to help you.
And I'd agree that signals can wait.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAko79b8ACgkQwuRiAT9o60+VowCg5zvB16xzUz6w7cqP6twu4xKv
9o0AoJuG3v9qkiB8SXVpk/D9nud2A8FM
=h/y8
-----END PGP SIGNATURE-----
