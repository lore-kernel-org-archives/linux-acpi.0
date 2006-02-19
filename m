From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: 2.6.16-rc4: known regressions
Date: Sun, 19 Feb 2006 13:06:45 +0200
Message-ID: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.207]:51134 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932397AbWBSLG4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Feb 2006 06:06:56 -0500
Received: by nproxy.gmail.com with SMTP id l37so494814nfc
        for <linux-acpi@vger.kernel.org>; Sun, 19 Feb 2006 03:06:55 -0800 (PST)
In-Reply-To: <20060217231444.GM4422@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, paulus@samba.org, linuxppc-dev@ozlabs.org, gregkh@suse.de, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, len.brown@intel.com, linux-acpi@vger.kernel.org, Meelis Roos <mroos@linux.ee>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz

On 2/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
> Submitter  : John Stultz <johnstul@us.ibm.com>
> Status     : still present in -git two days ago

This is not ppc only. I have the exact same problem on Gentoo
Linux/x86. No ipod events on 2.6.16-rc1, whereas 2.6.15 works fine.
Haven't had the time to investigate further yet, sorry.

                          Pekka
