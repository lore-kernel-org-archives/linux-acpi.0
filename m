From: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake
 howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 10:09:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <406A8ADD.9040108@mesias.co.uk>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com> <20040330233155.463A.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040330233155.463A.COUNT0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Cc: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Huw

More info and one small fix for some people's problems:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=117032

See:

------- Additional Comments From Didier.Moens-A49opszgxRtVsUKGZV2E3Q@public.gmane.org  2004-03-30 
16:03 -------
- Tested with stock FC2test2 kernel 2.6.3-2.1.253.2.1 on FC2test1
distrib : reboots after suspend with both APM and ACPI.

- Recompiled kernel 2.6.3-2.1.253.2.1 with
CONFIG_X86_4G,CONFIG_X86_4G_VM_LAYOUT,CONFIG_HIGHMEM4G=n :
after booting in single user mode (no extra modules loaded), both APM
and ACPI resume after suspend. (For ACPI, this is a first on my IBM
ThinkPad A30p.)

So be patient, some people are working on it and we will get there in 
the end.

More of a problem IMHO is notebook hardware still reasonably current but 
with broken ACPI implementations and no hope of a BIOS update. These 
people are stuck with APM and risk being left out when ACPI works for 
everyone else. I have posted my details on the ACPI list but 
unfortunately it seems true that no-one cares.

-Cam


-- 
camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org                                                 <--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
