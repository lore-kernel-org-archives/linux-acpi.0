From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: Re: making progress with ACPI was: ACPI small patch up date
Date: Wed, 30 Oct 2002 07:08:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210300708.37599.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A489@orsmsx119.jf.intel.com>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A489-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mittwoch, 30. Oktober 2002 00:50, Grover, Andrew wrote:

>
> We can fix bugs, the problem is *diagnosing* the issue. There's only so
> much diagnosis that can be done without the hardware. If you say "line 444
> of ec.c is acquiring a semaphore at interrupt level" that's probably
> enough. If you post a patch, we'll apply it. If you just say "my system
> hangs" then it's a lot harder. Sometimes the dmesg or DSDT are enough that
> other people can suss out what might be the problem -- sometimes not.
>

Hm. Give me some debugging hints. I'm not a kernel hacker, and i see the need 
for ACPI, but this stuff is complex. I have not the time and i am not willing 
to understand every line in the code. But i'm willing to help you to help you 
to fix problems in the code. 

ACPI_FUNCTION_TRACE looks for me like a function that can help.  Should it 
work if i change acpi_set_debug(..) to ACPI_DEBUG_HIGH in acpi_init(void)?  
Last try i get a kernel that don't start or was not able to send any 
printk-message.
(clean 2.4.20-pre11, newest patched ACPI patch, compiled into, not modules, 
gcc3.2)

Problem is, that thermal and processor doesn't work anymore, no error message, 
no warning... no hint ;-)

<Earny>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
