From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [BKPATCH] ACPI for 2.6
Date: Fri, 12 Nov 2004 18:42:48 +0100
Message-ID: <20041112174248.GA4267@openzaurus.ucw.cz>
References: <1099986428.6090.53.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261465AbUKLRo7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1099986428.6090.53.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi!


> <len.brown@intel.com> (04/11/05 1.1803.163.1)
>    [ACPI] Allow limiting idle C-States.
>    
>    Useful to workaround C3 ipw2100 packet loss,
>    reducing noise or boot issues on some models.
>    http://bugme.osdl.org/show_bug.cgi?id=3549
>    
>    For static processor driver, boot cmdline:
>    processor.acpi_cstate_limit=2

You certainly win "ugliest parameter of the month" contest :-).

What about processor.max_cstate= or something?


> <len.brown@intel.com> (04/10/18 1.1803.119.24)
>    [ACPI] add module parameters: processor.c2=[0,1] processor.c3=[0,1]
>    to disable/enable C2 or C3
>    blacklist entries for R40e and Medion 41700

So we have two independend ways to disable C states?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
