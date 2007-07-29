From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: ide problems: 2.6.22-git17 working, 2.6.23-rc1* is not
Date: Sun, 29 Jul 2007 05:54:22 +0200
Message-ID: <46AC0F6E.2000008@googlemail.com>
References: <20070727193832.GA20289@dth.net> <200707290142.53689.bzolnier@gmail.com> <20070729012324.GA29723@dth.net> <46ABFFE4.3060703@googlemail.com> <20070729033030.GA24636@dth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760142AbXG2D6t@vger.kernel.org>
In-Reply-To: <20070729033030.GA24636@dth.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny ter Haar <dth@dth.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Danny ter Haar wrote:
[ added  linux-acpi and Len to CC ]
> Quoting Gabriel C (nix.or.die@googlemail.com):
>> Maybe try to : 
>> disable BSG ( maybe some leftover bug )
>> boot acpi=off ( that got merged kind late )
> 
> My first git disected kernel wouldn't boot, but with
> acpi=off it would indeed boot!

Now while we think is ACPI this should be easy for you to bisect.

This commit http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=39804b20f62532fa05c2a8c3e2d1ae551fd0327b
merged ACPI so this one should be your first bad one.

Maybe Len has some idea and you don't need to bisect :)

> 
> As did the 2.6.23-rc1-git5 kernel...
> 
> I will bisect further to find out exactly what patch is
> playing up in my particular setup.
> 
> thanks for the tip! ;-)

You are welcome :)

> 
> Danny
> 

Gabriel
