From: Takayoshi Kochi <kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org>
Subject: Re: Fix wake GPE enabling
Date: Thu, 08 Apr 2004 22:50:04 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040408.225004.133816625.kochi@netbsd.org>
References: <37F890616C995246BE76B3E6B2DBE055442912@orsmsx403.jf.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE055442912-sBd4vmA9Se7vCEQmvpVV9VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] Fix wake GPE enabling
Date: Wed, 7 Apr 2004 14:34:43 -0700

> 
> No, this does not fit the model correctly.
> 
> It is the responsibility of the upper software to selectively enable the
> devices which are to be used for wakeup.  This is one of the functions
> of the AcpiGpeEnable interface.  The ACPI CA core cannot just blindly
> enable all "wake" GPEs.
> 
> The ACPI CA core simply identifies the "wake" GPEs in order to leave
> them disabled during runtime.

Hm, I might be misunderstanding, but my understanding is as follows
(this almost agrees with Dominik's second post):

1. Wake GPEs and runtime GPEs are _not_ exclusive but overwrapping
   by default.
   (Is it _explicitly_ stated in the spec that Wake GPE and runtime
    GPEs are exclusive?)

2. All GPEs should be enabled by default.
   Because in many AMLs Non-Wake GPEs are also used as runtime
   GPEs and we can't ignore them.  Are there *any magic* by which
   OSPM can know which Wake GPE is also runtime GPE?
   Should we list all the combination of every existing BIOS
   and wake-and-runtime GPE? :)
   Providing an interface of specifying which Wake GPE is actually
   runtime GPE sounds very silly idea (as you know, most people are _not_
   acpi savvy and even ACPI hackers has to disassemble and understand
   which GPE does what for it).

3. Upon entering sleep state, all GPEs should be disabled except
   Wake GPEs for appropriate levels of sleep.  Current implementation
   ignores the second parameter of _PRW and thus it is considered
   incomplete, anyway.

   There might be APIs to set or reset the Wake flag (as well as
   lowest power state) of a GPE, in case one wants to set
   the flag manually, although the flag should be set
   automatically by parsing _PRW and these APIs are not needed usually.

   The ACPI_EVENT_WAKE_ENABLE flag for the AcpiEnableGpe()
   is unnecessary.

So from my understanding, the current implementation of
_PRW and Wake GPEs needs revamp.

Anyway, let's clarify what's wake GPEs and how to handle wake GPEs
first.

Dominik, thanks for throwing this issue into discussion.

---
Takayoshi Kochi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
