From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [STABLE PATCH .26 .27] ACPI: avoid empty file name in sysfs
Date: Mon, 17 Nov 2008 09:40:12 +0800
Message-ID: <1226886012.15014.231.camel@rzhang-dt>
References: <alpine.LFD.2.00.0811130015100.3128@localhost.localdomain>
	 <20081115171725.GB1523@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755987AbYKQBkb@vger.kernel.org>
In-Reply-To: <20081115171725.GB1523@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Len Brown <lenb@kernel.org>, "stable@kernel.org" <stable@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2008-11-16 at 01:17 +0800, Pavel Machek wrote:
> Hi!
> 
> > upstream 4feba70a2c1a1a0c96909f657f48b2e11e682370
> > 
> > Since commit bc45b1d39a925b56796bebf8a397a0491489d85c acpi tables are
> > allowed to have an empty signature and /sys/firmware/acpi/tables uses the
> > signature as filename.  Applications using naive recursion through /sys
> > loop forever.  A possible solution would be: (replacing the zero length
> > filename with the string "NULL")
> 
> What about using some string that is not a valid table name? Shorter
> than 4 characters? AFAICT,
> 'NULL' table could be added to acpi in future...?
> 
> What if *two* tales have empty signature?
there are "NULL1" and "NULL2" in this case.

thanks,
rui
