From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Mon, 13 Mar 2006 14:38:04 +0800
Message-ID: <756b48450603122238l36e8615dy497b7e4e34dc2fb4@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F840B22AB1A@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:19493 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751694AbWCMGiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Mar 2006 01:38:05 -0500
Received: by pproxy.gmail.com with SMTP id x66so2254237pye
        for <linux-acpi@vger.kernel.org>; Sun, 12 Mar 2006 22:38:04 -0800 (PST)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B22AB1A@pdsmsx403>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/8/06, Yu, Luming <luming.yu@intel.com> wrote:
> I suggest LCD support in hotkey.c like:
> http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view
>
> Config userspace acpi daemon to respond events by evoking
> LCD._BCM with command:
>        echo -n xx > /sys/hotkey/brightness.
>

A quick question here. I took a look at your patch adding hotkeylib. I
see brightness_show/store callbacks and I think they end up calling 
write_acpi_int to do the actual method eval.

So I assume my action_method has got to be "_BCM". I don't have a poll
method but it looks like I'll need to put something in there since you
check for it. Atlas has a _BCL. I guess I'll just use that.

+       if(!poll_handle || !poll_method || !action_handle || !action_method)
+               goto do_fail;

>From what I can tell, it looks like I have to use ACPILCD00 as my HID
in this hotkey code. Right? So basically, it'd be something like:
        {
                .ids = "ACPILCD00",
                .name = "brightness",
                .poll_method = "_BCL",
                .action_method = "_BCM",
                .min = 1,
                .max = 31,
                .id = 10001,
        },

So if I get that working, is that what you are saying is the right way
to do brightness support for limited devices like Atlas? I guess it
feels kind of odd to me because it's an LCD device rather than a
hotkey device. But afaict it looks like doing that will work fine and
have the added benefit of not creating any new /proc entries. So let
me know if I understood you correctly.

By the way, I just applied your sequence of patches from
http://bugzilla.kernel.org/show_bug.cgi?id=5749 to my tree. You know,
if it's okay with you, I'll post the full diff from below to your bug
report so that the next person doesn't have to cherrypick.

wget "http://bugzilla.kernel.org/attachment.cgi?id=6839&action=view"
wget "http://bugzilla.kernel.org/attachment.cgi?id=6840&action=view"
wget "http://bugzilla.kernel.org/attachment.cgi?id=6841&action=view"
wget "http://bugzilla.kernel.org/attachment.cgi?id=6842&action=view"
wget "http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view"
wget "http://bugzilla.kernel.org/attachment.cgi?id=7061&action=view"
wget "http://bugzilla.kernel.org/attachment.cgi?id=7060&action=view"

Thanks,
jayakumar
