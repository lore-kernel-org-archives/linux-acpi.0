From: michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org
Subject: Re: Suspend 2 disk
Date: Sat, 15 Nov 2003 14:32:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068899560.3fb61ce834a70@webmail2.tau.ac.il>
References: <1068895745.944.9.camel@nexus.l3jane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1068895745.944.9.camel-FRzfUGJImGaWJdCIYJbLrA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Quoting Marc Franquesa <mark-KaoEA2pfkXWsTnJN9+BGXg@public.gmane.org>:

> First, excuseme if I write to the wrong list, I don't speak english very
> well too.
> 
> I'm using a 2.4.22 kernel patched with ACPI-20030916 in Red Hat Linux
> 9.0 in a Dell Inspiron 4150 and works very well despite some little an
> unfrequently problems with X when switching to console via Ctrl+Alt+Fx
> (but this is not the cause of writing this)
> 
> Before ACPI, I use APM and with APM I can use the S2D (Suspend 2 Disk)
> feature of my dell without any additonal software or kernel/patch, using
> only the 'apm -s' command and the BIOS of my Dell.
> 
> ¿Is there any way to do the same thing with ACPI without using any 2.4
> non-patched kernel? ¿How?
> 
> I know what says the docs, that I need to patch the kernel and use
> additional software, but if in the past my Laptop made it without any
> special software, I belive that it can make it now also without any
> patch.
> 


AFAIK it is not possible with 2.4 kernels. Suspending on 2.4 is only possible
using the bios with apm or suspend to disk using swsusp (software suspend).
On 2.6 kernels it is possible to use bios aided suspend, but it is not stable
yet so it might work on your laptop and it might not.

> 
> Thanks for any comment or explanation.
> 
> Salut
> 
> 
> 
> 
> 




----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
