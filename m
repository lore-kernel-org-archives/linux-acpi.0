From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Wrong AC state
Date: Tue, 25 May 2004 21:56:03 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040525185603.GE10355@luna.mooo.com>
References: <40B346FC.9090908@mpi-magdeburg.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40B346FC.9090908-VDBW1ITIq+y+DWMCimbbknqWYbMAw+HU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 25, 2004 at 03:15:40PM +0200, Martin Ginkel wrote:
> Dear ACPI-Folks,
> 
> I am trying to debug the code for reading the ac_adapter state.
> On my laptop (Fujitsu-Siemens Amilo D 8830) this seems to be partially 
> broken.
> The /proc/ac_adapter/AC0/state has a value on-line or off-line from 
> boot-time and doesn't change later on.
> I already switched on debugging in the ac-module and the
> acpi_ac_get_state function gets called every time I cat the state-file.
> But it obviously reads the same value again and again.
> 
> Anyways: plugging the AC in and out get's recognized by the hardware:
> The display dims up and down, using Windows the correct state is shown
> and in Linux ACPI is getting 2 IRQs (according to /proc/interrupts).
> 

Try also checking the battery module. There is (or was) a bug that
after suspend the machine would exhibit the same behavior you are
describing and a workaround was to unload the battery module before
suspend and reload it after.

> Does anyone have suggestions where to start debugging?
> 
> 	Best regards
> 	Martin
> 
> 
> 
> 
> 
> -- 
> +-[Martin Ginkel]-------------[mailto:mginkel(at)mpi-magdeburg.mpg.de]-+
> | MPI Magdeburg, Zi S2.09    Sandtorstr. 1, D-39106 Magdeburg, Germany |
> |                                                                      |
> |                                                                      |
> +-[tel/fax: +49 391 6110 482/529]----[http://www.mpi-magdeburg.mpg.de]-+
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> +++++++++++++++++++++++++++++++++++++++++++
> This Mail Was Scanned By Mail-seCure System
> at the Tel-Aviv University CC.
> 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
