From: David van Hoose <david.vanhoose-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: Re: Linux 2.4.23-pre8
Date: Mon, 27 Oct 2003 14:35:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F9D7373.9000909@comcast.net>
References: <Pine.LNX.4.44.0310271118340.17121-200000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0310271118340.17121-200000-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Mon, 27 Oct 2003, Marcelo Tosatti wrote:
>>
>>On Fri, 24 Oct 2003, David van Hoose wrote:
>>
>>
>>>Attached config, boot messages, and interrupts for 2.6.0-test8-bk2.
>>>The boot messages do not have any USB debug, but do have ACPI debug. 
>>>Also, all of my USB ports work 100% of the time on 2.6 with ACPI enabled.
>>
>>David, 
>>
>>Have you tried what Len suggested in the bugzilla?
>>
>>----------
>>Created an attachment (id=1185)
>>SIS I2C quirk foundin 2.6 but not in 2.4
>>
>>One difference between 2.4 and 2.6 is the attached SIS quirk added for 
>>I2C.
>>
>>Please back that quirk out of your 2.6 tree like so:
>>
>>patch --dry-run -Rp1 </tmp/sis_quirk_26.diff
>>
>>remove the code that depends on it from your .config:
>>CONFIG_I2C_SIS96X=n
>>
>>and see if that makes 2.6 mis-behave like 2.4, or if USB still runs.
>>
>>Also, please verify for me that you get ACPI events properly.
>>If you connect your USB mouse to one of the ports that isn't shared
>>with acpi, then you should be able to trigger ACPI interrupts by
>>pressing your power button.  (if acpid is enabled, it may shut down your
>>system,
>>so you may want to disable that first), and observering the
>>/proc/interrupts row for acpi incrementing for each button press.
> 
> 
> Attached is a patch against -test9 to remove the SiS quirks.

I patched test9 and it still works the same. My /proc/interrupts doesn't 
change when I use the PM buttons on my keyboard. :-/
USB works. All 6 ports.

-David

<SNIP>



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
