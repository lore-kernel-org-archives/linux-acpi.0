From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: acpi_ec_space_handler flooding logs
Date: Wed, 17 Aug 2005 11:44:54 +0200
Message-ID: <43030716.9000105@suse.de>
References: <1123000573.12447.15.camel@x10>  <42FC5C0D.4010907@suse.de> <1124224663.28295.13.camel@x10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1124224663.28295.13.camel@x10>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Schricker <fschricker-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Florian Schricker wrote:
> On Fri, 2005-08-12 at 10:21 +0200, Thomas Renninger wrote:
> 
> [DSDT fixes]
> 
>>>This broken DSDT is currently active, fails with battery as mentioned -
>>>and: floods dmesg / /var/log/messages with
>>>
>>>  ACPI: acpi_ec_space_handler: bit_width should be 8
>>Could you try whether the above suggestions fix your battery?
> 
> They did - everything seems to be just fine now.
> Thanks a lot!
> 
> 
>>I thought this one is workarounded?
> 
> Well, uhmm... */me is puzzled
> 
> 
>>At least it is tried: ACPI: acpi_ec_space_handler: bit_width should be 8
>>but maybe it does not work as expected?
> 
> Anything I could check, provide, test?

It would be worth to test whether latest EC burst mode implementations
still walks this code path. If, you probably still have battery problems.

You could try latest 2.6.13-rcX patches and enable ec_burst=1 (with the
unfixed DSDT).
If this works, you will have to boot with this option a few kernels.
But it shouldn't be worth to look at any further as this will get default
sooner or later.

If you still have battery problems, you should open a bug at:
http://bugzilla.kernel.org
assign it to the ACPI component and take me into CC.

....

Thanks for digging into this,

    Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
