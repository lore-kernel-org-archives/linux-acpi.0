From: Faye Pearson <faye-jCzc14SaIAzJdhwusi3v/KxOck334EZe@public.gmane.org>
Subject: Re: DSDT hacking issues ...
Date: Tue, 30 Jul 2002 13:50:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730125044.GB8925@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Sourav K Mandal [smandal-DPNOqEs/LNQ@public.gmane.org] wrote:
> So I'm trying to patch my DSDT (for my Compaq Presario 2800).  
> Unfortunately, when I do an "acpidmp  /proc/acpi/dsdt" I end up with 
> some gibberish that looks like the output from hexdump, rather than 
> code.   I am using the latest pmtools (rev. 200-10730) distro from the 
> Intel ACPI site.

You need to use pacpidump and that won't work direct from the proc file
so you need to cp to a real file on disc before you can process it (or
you get a segfault)

> BTW, the device ids in /proc/acpi are weird -- my CPU is called "C000", 
> and my ac adapter "C11A" -- is this also due to a buggy native DSDT,
> or laziness by the OEM?

Could be both :)

http://people.freebsd.org/~takawata/pacpidump.tar.gz

Just copy config.h.linux to config.h and make.

-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000

The new Congressmen say they're going to turn the government around.  I
hope I don't get run over again.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
