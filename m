From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Compilation error acpi-20020725-2.4.18
Date: Fri, 26 Jul 2002 16:27:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020726142734.GL11818@dutidad.twi.tudelft.nl>
References: <20020726141906.3578.qmail@gonicus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020726141906.3578.qmail-t5zJAXK//yKELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Birger Peer =?iso-8859-1?Q?K=FCpper?= <kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 26, 2002 at 04:19:05PM +0200, Birger Peer Küpper wrote:
> dswload.c: In function `acpi_ds_load2_end_op':
> dswload.c:451: structure has no member named `name'
> make[4]: *** [dswload.o] Error 1
> make[4]: Leaving directory `/usr/src/linux/drivers/acpi/dispatcher'
> make[3]: *** [first_rule] Error 2
> make[3]: Leaving directory `/usr/src/linux/drivers/acpi/dispatcher'
> make[2]: *** [_subdir_dispatcher] Error 2
> make[2]: Leaving directory `/usr/src/linux/drivers/acpi'
> make[1]: *** [_subdir_acpi] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_dir_drivers] Error 2

There's a problem with a define.  I fixed it on my box but I'm now getting
an oops on bootup; this oops might be due to some other problem with ACPI on
my system.  You could TRY to add #define ACPI_DISASSEMBLER to the top of
drivers/acpi/include/platform/acenv.h and rebuild, but I would not recommend
it, at least not until some of the experienced ACPI kids have looked at it.

I'll also be posting more information soon, I think.

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
