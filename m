From: Fabien Crespel <fabien@crespel.net>
Subject: Re: Fwd: [PATCH 01/02] Initial work to let ACPI buttons work over
    INPUT layer
Date: Thu, 15 Jan 2009 13:31:47 +0100
Message-ID: <496F2CB3.5000102@crespel.net>
References: <200811291834.46109.dnascimento@gmail.com>	 <4ff2fa00812190834s8ef5629ofa1f17a74aa6bfef@mail.gmail.com>	 <1231328320.402.5.camel@zimtstern>	 <71cd59b00901120359h4c0ff723v4f49bdd180fcc9e8@mail.gmail.com>	 <71cd59b00901120400t1545e85avcfaa5b23a3c3ee79@mail.gmail.com> <71cd59b00901140157n760b8e55i13119bfdb193b9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2e.orange.fr ([80.12.242.111]:61673 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490AbZAOMbq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jan 2009 07:31:46 -0500
In-Reply-To: <71cd59b00901140157n760b8e55i13119bfdb193b9d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Timo Hoenig <thoenig@nouse.net>, Nicolas Trangez <ikke@nicolast.be>, sziwan@users.sourceforge.net, linux-acpi@vger.kernel.org, Daniel Nascimento <dnascimento@gmail.com>, acpi4asus-user@lists.sourceforge.net

Corentin Chary wrote:
> Hi,
> Just done a patch based on eeepc-laptop.
> You can get it there:
> http://git.iksaif.net/?p=acpi4asus.git;a=shortlog;h=refs/heads/asus-laptop-input
> I didn't test it yet, I'll only have my laptops this weekend.
> Could you test it please ?
> Thanks
> 

Hello,

I haven't tested this patch, but there is a mistake in the keymap here:

{KE_KEY, 0x7D, KEY_BLUETOOTH}, /* Bluetooth up */
{KE_KEY, 0x7E, KEY_BLUETOOTH}, /* Bluetooth down */

These are not keys, they are notifications that occur *after* the bluetooth state
is changed by the firmware (by pressing the bluetooth key on some models, for
example). Therefore, they should not be reported to the input layer.

There is also a 0x88 scancode for the radio key on some models. On Windows, this
key cycles through radio states: WLAN + BT => WLAN => BT => None. AFAIK there is
no equivalent on Linux yet for such a key... What would be best to do to support it?

- Fabien.

