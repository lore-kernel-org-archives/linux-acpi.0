From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
Date: Tue, 21 Sep 2004 08:18:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1095776285.6307.0.camel@tdi>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267344AbUIUORl@vger.kernel.org>
In-Reply-To: <20040921122428.GB2383@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-09-21 at 14:24 +0200, Pavel Machek wrote:
> Hi!
> 
> >    I've lost track of how many of these patches I've done, but here's
> > the much anticipated next revision ;^)  The purpose of this patch is to
> > expose ACPI objects in the already existing namespace in sysfs
> > (/sys/firmware/acpi/namespace/ACPI).  There's a lot of information
> 
> Perhaps this needs some description in Documentation/ ?
> 

   Yes, definitely.  I'll work on some.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab
