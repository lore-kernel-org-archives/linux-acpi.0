From: Jes Sorensen <jes-UC6nUKlm/0l5V+5IkYBVeNBPR1lH4CV8@public.gmane.org>
Subject: Re: RFC: ACPI table overflow handling
Date: 11 Jan 2004 06:49:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yq0fzemiu1x.fsf@wildopensource.com>
References: <16381.27904.580087.442358@gargle.gargle.HOWL>
	<200401080920.04906.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200401080920.04906.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jbarnes-sJ/iWh9BUns@public.gmane.org, steiner-sJ/iWh9BUns@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "Bjorn" == Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org> writes:

Bjorn> On Thursday 08 January 2004 7:45 am, Jes Sorensen wrote:
>> I could just hack the NUMA srat_num_cpus handling code to have a
>> limit as IMHO it is a lot cleaner to improve the
>> acpi_table_parse_madt() API by adding a max_entries argument and
>> then have acpi_table_parse_madt spit out a warning if it found too
>> many entries.

Bjorn> I really like this idea.  I notice you didn't take the
Bjorn> opportunity to remove the ad hoc checking in ia64
Bjorn> acpi_parse_lsapic; probably that's the next step.  Also, did
Bjorn> you consider using max_entries==0 to signify "unlimited"?  Zero
Bjorn> seems like an otherwise useless value for max_entries and would
Bjorn> avoid having to choose an arbitrary limit.

Hi Bjorn,

Since it seems my efforts weren't for nothing then I'll take another
round on this one and clean it up further. Zero is such a pretty
number so I agree, lets make that be unlimited.

Cheers,
Jes


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
