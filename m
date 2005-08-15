From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch] Feature removal: ACPI S4bios support
Date: Mon, 15 Aug 2005 18:26:38 +0200
Message-ID: <20050815162638.GA2379@elf.ucw.cz>
References: <200508111417.47499.blaisorblade@yahoo.it> <20050812132444.GH1826@elf.ucw.cz> <20050815160007.GA3614@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050815160007.GA3614-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Cc: Blaisorblade <blaisorblade-whZMOeQn8C0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Remove S4BIOS support. It is pretty useless, and only ever worked for
> > _me_ once. (I do not think anyone else ever tried it). It was in
> > feature-removal for a long time, and it should have been removed before.
> >...
> 
> You've forgotten to remove the feature-removal-schedule.txt entry in 
> your patch.  ;-)

Well, that can always be done later. There are probably other small
pieces that can be removed now. But I got neither ACK nor NAK on the
patch :-(.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
