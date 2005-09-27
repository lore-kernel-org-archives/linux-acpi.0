From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: 2.6.11 issues with S3
Date: Tue, 27 Sep 2005 14:43:38 +0200
Message-ID: <20050927124338.GA9484@openzaurus.ucw.cz>
References: <4A60C83D027E224BAA4550FB1A2B120E9DFBB1@fcexmb04.efi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A60C83D027E224BAA4550FB1A2B120E9DFBB1-/0EpVhShIWCyvBr3IBtpkhUaVx6/PbGo@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ranjan Parthasarathy <Ranjan.Parthasarathy-IrU4XInhIXM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am trying to get S3 working on my system running a 2.6.11 (upgraded from
> 2.6.4) kernel. On boot up I can put the system to S3 and then wol using magic
> packets. Subsequent attempts to put the system to S3 fail with the error

Try with recent kernel.

> "stopping tasks failed (208 tasks remaining)". I tried changing the TIMEOUT
> from the default 6 HZ in kernel/power/process.c to a larger number and the
> system is now able to suspend but takes about 20 - 30 seconds for it to go to
> suspend. Why is it taking that long? Also shouldn't the timeout be dependent
> on the number of processes that we are trying to put to suspend vs a constant
> value?
>  
> On my system, the error is easily reproducible with a simple shell script
> that spawns a lot of processes. As the number of processes increase, after
> around 70 odd processes in the system I start seeing failures while trying to
> suspend.

It was not really design to work on stressed system, but feel free to fix it.
Sometimes even make -j 10 on kernel breaks it.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
