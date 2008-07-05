From: Theodore Tso <tytso@mit.edu>
Subject: Re: Battery life difference
Date: Sat, 5 Jul 2008 09:36:01 -0400
Message-ID: <20080705133601.GA20240@mit.edu>
References: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:58883 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752043AbYGENgK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jul 2008 09:36:10 -0400
Content-Disposition: inline
In-Reply-To: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, Jul 05, 2008 at 04:17:01PM +0300, Felipe Balbi wrote:
> 
> . x61s with windows xp
> wifi on but not connected to any network, bluetooth on,
> display is in the less brighten state.
> 
> . x61s with ubuntu 8.04
> all radios off (modules removed and hw switch off),
> display is in the less brighten state.
> powertop runned and I did what it suggested me
> to do. Also did some other stuff from thinkwiki on
> how to reduce power consumption.

You didn't say which battery you are using; I'm guessing you are using
the 4 cell slim-line battery, which is rated at 28.8 Watt-hours?

How many Watts is Powertop reporting that you are using?  I'm down to
around 8-9 watts, and around 9.5 watts in "airplane mail reading mail"
(wireless disabled, USB modules unloaded, screen brightness turned way
down, laptop_mode enabled, all mail messages pulled into memory, and
reading/deleting mail using mutt, a character-mode based mail reader
--- if you use Evolution, your energy usage will definitely be higher  :-).

> Well, what could still be using the system power so
> much ?

See http://thunk.org/tytso/blog/2007/10/29/tip-o-the-hat-wag-o-the-finger-linux-power-savings-for-laptop-users/

					- Ted
