From: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>
Subject: Re: Re: s3_late_bios
Date: Wed, 10 Nov 2004 08:20:03 +0100
Message-ID: <20041110072003.GA13561@tate.loria.fr>
References: <20041108144947.GA31267@tate.loria.fr> <20041108213558.GB4607@elf.ucw.cz> <418FEAD5.1000007@root.org> <20041109125522.GA8015@tate.loria.fr> <419127E6.3000603@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <419127E6.3000603-Y6VGUYTwhu0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 09, 2004 at 12:26:14PM -0800, Nate Lawson wrote:
> I mostly work on FreeBSD and since it has clean vm86 support routines, 
> it doesn't involve any inline assembly to do the lcall there.  I assume 
> Linux has something similar.  I think re-entering real mode and 
> overloading the resume asm code to run just one instruction is a bit of 
> a hack.

I don't think linux has a vm86 api at all.

E.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
