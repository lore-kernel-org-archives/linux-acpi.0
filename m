From: Andi Kleen <ak@suse.de>
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
Date: Tue, 21 Sep 2004 21:18:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040921191826.GF18938@wotan.suse.de>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi> <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de> <1095794035.24751.54.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267973AbUIUTS3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1095794035.24751.54.camel@tdi>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>, acpi-devel <acpi-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

>    All pointers are actually interpreted as offsets into the buffer for
> this interface.  They are not actually pointers.  I believe the 32bit
> emulation problem is limited to an ILP32 application generating data
> structures appropriate for an LP64 kernel.  While difficult, it can be
> done.

If this involves patching the application - no it cannot be done.
The 64bit kernel is supposed to run vanilla 32bit user land.

Please find some other solution for this. An ioctl doesn't sound that bad.

-Andi
