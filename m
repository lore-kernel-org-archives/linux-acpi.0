From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Crash with fs corruption on 2.4.23-rc1 + CONFIG_ACPI_PROCESSOR
Date: Sat, 15 Nov 2003 07:50:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031115065020.GO32464@poupinou.org>
References: <20031113161857.GM26911@roosevelt.alcove-fr> <20031114124713.GK32464@poupinou.org> <20031114152403.GK29316@roosevelt.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031114152403.GK29316-sxQ6dllMCJFOpCWnugOeNx8pCrqmY5it@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 14, 2003 at 04:24:03PM +0100, Stelian Pop wrote:
> On Fri, Nov 14, 2003 at 01:47:13PM +0100, Ducrot Bruno wrote:
> 
> > > Attached you'll find the .config and dmesg in case it is useful...
> > > 
> > 
> > Have you a decoded oops?
> 
> Here is one, hand copied because there is no serial port on this laptop...
> 
> I'm not sure it is useful because it shows the actual corruption in ext3
> code more than the place where the memory gets corrupted...
> 
> But I'm 100% positive that this does happen only *after* inserting
> the processor.o module...
> 

Thanks anyway.  Can you tell if processor C3 is enabled with a 2.6 kernel?

Also, I would like to receive the lspci -xxx -s0:0.0 for the northbridge,
and the same for all the function of the PIIX4 southbridge.

Even if you may think that it is irrelevant, I would like to receive
the output of speedstep-detect from
ftp://ftp.poupinou.org/cpufreq/speedstep-detect.tar.gz

because it dump the pm io registers of the PIIX4, regardless of the processor..

I think the trouble come from C3, just need to check some values.  If you
can, it may be usefull that you disable C3, with something like that:


--- linux-2.4.23-rc1/drivers/acpi/processor.c	2003/11/15 06:47:38	1.1
+++ linux-2.4.23-rc1/drivers/acpi/processor.c	2003/11/15 06:48:46
@@ -742,6 +742,8 @@
 	 */
 	if (pr->power.states[ACPI_STATE_C3].address) {
 
+		acpi_fadt.plvl3_lat = 1234;
+
 		pr->power.states[ACPI_STATE_C3].latency = acpi_fadt.plvl3_lat;
 
 		/*

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
