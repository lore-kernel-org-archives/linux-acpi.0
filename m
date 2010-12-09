From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC  - V2] - Mapping ACPI tables as CACHED
Date: Thu, 09 Dec 2010 01:12:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012090104320.27964@x980>
References: <20100722152220.GA18290@sgi.com>
 <20100724001449.GA9618@khazad-dum.debian.net> <4C743C0F.2010101@zytor.com>
 <20100826171704.GA21584@sgi.com> <4C76AD82.2030105@zytor.com>
 <20101208212244.GA24280@sgi.com> <4D00308B.2040009@zytor.com>
 <20101209035025.GB6697@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20101209035025.GB6697@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, hmh@hmh.eng.br, mingo@elte.hu, tglx@linutronix.de, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com
List-Id: linux-acpi@vger.kernel.org

Jack,

I agree that we should try to map cached always,
and that we should try do the same thing on all platforms.

I favor continuing to map the tables in-place.
Yes, Toshiba has a quirk and we copy the tables there.
But frankly, we have no idea what the heck Toshiba is doing
and we don't want every platform to pay the price because
of some vendor specific evil.

Please send an upstream ready version of this RFC
(checkpatch clean), labled with "PATCH".

thanks,
Len Brown, Intel Open Source Technology Center


ps. acpidump can be updated to use /sys/firmware/acpi/tables
to get rid of the mmap stuff.  That is someplace on our todo list...
