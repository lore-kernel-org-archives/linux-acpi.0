From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: /proc/acpi/sleep behaviour?
Date: Tue, 4 Mar 2003 18:40:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030304184035.6ace16db.nils@kernelconcepts.de>
References: <20030304175446.3930bcb7.nils@kernelconcepts.de>
	<20030304172226.GD7861@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030304172226.GD7861-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 4 Mar 2003 18:22:26 +0100
Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, Mar 04, 2003 at 05:54:46PM +0100, Nils Faerber wrote:
> > Just a short question:
> > 	How is sleep supposed to work?
> > When I do a 
> > 	echo -n 4 > /proc/acpi/sleep
> > on recent ACPI kernels (2.4.21-pre4 with ACPI 20030228 + swsusp beta
> > 19) everything works quite fine but the "echo" never returns. After
> > resume I have to kill "echo".
> Last time I checked, the swsusp support is not well integrated.
> I can not tell though for recent swsusp patches.

I can't judge this either but the same in my eyes misbehaviour is IMHO
also true for 2.5.6x kernels without directly involved swsusp so I would
suspect this to be more of an ACPI problem...

> please use /proc/sys/kernel/suspend instead.
Err... /proc/sys/kernel/swsusp you ment, right?

> Forgot to say also that you should bug report to swsusp mailing list.
That's true, sorry!

> Ducrot Bruno
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
