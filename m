From: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Subject: Re: C2 or C3 on Presario 2110US?
Date: Wed, 19 Mar 2003 11:33:51 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048102431.aeb99a7f4f1e7@carlthompson.net>
References: <F760B14C9561B941B89469F59BA3A847E96D05@orsmsx401.jf.intel.com>
	<1047626263.be18a116566a8@carlthompson.net>
	<1048007509.e1d19c401c6ab@carlthompson.net>
	<20030319110729.GZ8319@poup.poupinou.org>
	<1048095104.755549e671fee@carlthompson.net>
	<20030319180528.GE8319@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030319180528.GE8319-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Wow!  Thank you very much!  Yes, this works!  I also notice that this
problem also exists in the code for the C3 state.  I still don't have
performance or limit support but I do have PowerNow which I think is a
better way of doing the same thing, right?

Now I will wait and see if my fan goes off...  ;-)

Thank you from a very happy camper,
Carl Thompson

Quoting Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>:

> Hi!
> 
> On Wed, Mar 19, 2003 at 09:31:44AM -0800, Carl Thompson wrote:
> > OK, I have attached my ACPI tables and lspci -xxx output for the
> PMU device.
> >
> > Thank you,
> > Carl Thompson
> >
> > Quoting Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>:
> >
> > > Hi Carl,
> > >
> > > On Tue, Mar 18, 2003 at 09:11:49AM -0800, Carl Thompson wrote:
> > > > Just wondering if anyone can help me figure out how to get C2
> > > > working on my laptop...  Someone suggested that my processor
> P_BLK
> > > > might be the wrong size but I have no idea what that is and
> > > > searching for that string in the source yields nothing.
> > > >
> > > > Can anyone help me?
> > > >
> 
> In fact, it not your processor P_BLK size that is wrong:
> 
>     Scope (_PR)
>     {
>         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>                                            ^^^^
>                                          6 is correct.
>     }
> 
> but the FACS one:
> 
> ducrot@neptune:~/acpi_hack/carl$ cat FACP |
> ../../acpi/pmtools/acpidmp/acpitbl
> Signature:        FACP
> Length:           116
> Revision:         0x01
> Checksum:         0x97
> OEMID:            ATI
> OEM Table ID:     Raptor
> OEM Revision:     0x06040000
> Creator ID:       ATI
> Creator Revision: 0x000f4240
> FIRMWARE_CTRL:    0x1befffc0
> DSDT:             0x1bef8cf4
> INT_MODEL:        0x00
> SCI_INT:          9
> SMI_CMD:          0x000000b1
> ACPI_ENABLE:      0xf0
> ACPI_DISABLE:     0xf1
> S4BIOS_REQ:       0xf2
> PM1a_EVT_BLK:     0x00008000
> PM1b_EVT_BLK:     0x00000000
> PM1a_CNT_BLK:     0x0000fe10
> PM1b_CNT_BLK:     0x00000000
> PM2_CNT_BLK:      0x00008070
> PM_TMR_BLK:       0x00008008
> GPE0_BLK:         0x00008018
> GPE1_BLK:         0x00000000
> PM1_EVT_LEN:      4
> PM1_CNT_LEN:      2
> PM2_CNT_LEN:      1
> PM_TM_LEN:        4
> GPE0_BLK_LEN:     16
> GPE1_BLK_LEN:     0
> GPE1_BASE:        0
> P_LVL2_LAT:       100
> P_LVL3_LAT:       1001
> FLUSH_SIZE:       0
> FLUSH_STRIDE:     0
> DUTY_OFFSET:      1
> DUTY_WIDTH:       0
> DAY_ALRM:         0x0d
> MON_ALRM:         0x00
> CENTURY:          0x32
> Flags:            0x00000000
> 
> 
> The P_LVL2_LAT is too high: 100.
> It should be < 100.
> 
> I guess that actually windows will do:
> P_LVL2_LAT <= 100 then C2 OK
> 
> whereas ACPI-CA will do:
> P_LVL2_LAT < 100  then C2 OK
> 
> which is wrong (the keyword in spec is
> 'must be less than or equal to').
> 
> 
> Ah...  processor.c is wrong...
> 
> Try this:
> 
> --- linux-2.5.65/drivers/acpi/processor.c.old	2003-03-19
> 15:12:16.000000000 +0100
> +++ linux-2.5.65/drivers/acpi/processor.c	2003-03-19
> 15:13:22.000000000 +0100
> @@ -639,7 +639,7 @@
>  		/*
>  		 * C2 latency must be less than or equal to 100 microseconds.
>  		 */
> -		if (acpi_fadt.plvl2_lat >= ACPI_PROCESSOR_MAX_C2_LATENCY)
> +		if (acpi_fadt.plvl2_lat > ACPI_PROCESSOR_MAX_C2_LATENCY)
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				"C2 latency too large [%d]\n",
>  				acpi_fadt.plvl2_lat));
> 
> 
> 
> Cheers,
> 
> --
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 
> 






-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
