From: Garry Williams <gtwilliams@gmail.com>
Subject: Re: Suspend Medion Akoya LS
Date: Thu, 23 Mar 2006 05:47:40 -0500
Message-ID: <1143110861.12702.4.camel@localhost>
References: <20060320235923.5b6c948b@toodles.lindenlevy.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:21972 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932324AbWCWKro (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Mar 2006 05:47:44 -0500
Received: by xproxy.gmail.com with SMTP id t10so281581wxc
        for <linux-acpi@vger.kernel.org>; Thu, 23 Mar 2006 02:47:43 -0800 (PST)
In-Reply-To: <20060320235923.5b6c948b@toodles.lindenlevy.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "L. A. Linden Levy" <lindenle@uiuc.edu>
Cc: linux-acpi@vger.kernel.org, lindenle@gmail.com

On Mon, 2006-03-20 at 23:59 -0600, L. A. Linden Levy wrote:
> Hi when I use suspend my machine wont wake up unless i hit the power
> button but then it shuts down. It is like the keyboard is not
> registering when it is suspended. Can anyone help me make this work?
> 
> kernel 2.6.15

Try removing the button action that is specified in a file
in /etc/acpi/events.  It may be named sample.conf, depending on your
distribution.  Then you can safely wake by pressing the power button.

If that solves your problem and you still want to be able to call
shutdown(8) by hitting the power button, then disable/enable this button
rule in your suspend script.

-- 
Garry Williams -- +1 (678) 656-4579

