From: Jocelyn Jaubert <jaubert-6bugY6I12JBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Compaq Evo N600c DSDT woes
Date: Mon, 25 Nov 2002 18:44:11 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021125234411.GE833@yggdras.agere.com>
References: <200211251831.gAPIV3L16208@xabean.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200211251831.gAPIV3L16208-tC2FqGc0olKsTnJN9+BGXg@public.gmane.org>; from acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org on Mon, Nov 25, 2002 at 13:31:03 -0500
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

On 2002.11.25 13:31 Richard Harman wrote:
> I read through the archives about the Bios Override procedure
> (http://www.intel.com/technology/iapc/acpi/bios_override.htm) and how
> to fix some of the common DSDT problems "*PNPFOO" v.s. "PNPFOO".  Did
> that.  I also saw somebody else had a N600c, but no fixed DSDT as far
> as I could tell.  I'm still getting errors from the iasl compiler,
> because I don't have any clue about the AML language (willing and
> eager to learn though).  Do I need to go download the AML docs in pdf
> and figure out what I need to "fix" based on what my hardware is?

I have the same laptop, and followed the advice of Duncan Gibb. I 
modified my linux/drivers/acpi/acpi_drivers.h, replacing each PNP... 
with *PNP... I then recompiled the kernel. 
I know it's not really clean, but it works (even if I can only throttle 
my CPU speed).

Somebody told about updating the BIOS, taking a newer one from Compaq. 
Maybe you should try it ?

-- 
Jocelyn Jaubert


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
