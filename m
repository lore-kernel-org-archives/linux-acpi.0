From: Mike Wohlgemuth <mjw-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Subject: Re: Compaq Evo N800v: I have a fixed DSDT table
Date: Tue, 29 Apr 2003 16:14:10 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EAEDD12.9070106@woogie.net>
References: <20030428121157.A20348@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030428121157.A20348-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
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

Can I ask what version of ACPI you are running?  The lid button and the 
panel brightness doesn't work for me on my Evo N800c with bios F.18a. 
 I'm hoping the problem is a difference in the software, not in the 
hardware.

Thanks
Mike

Daniele Boffi wrote:

>Hi folks!
>
>Stimulated by the recent discussions on the list, I made some important
>progress on my (already satisfactory) fixed DSDT table for Evo N800v.
>
>You can find it at
>
>www-dimat.unipv.it/~boffi/compaq/custom-dsdt.hex
>
>I'll send it to acpi.sf.net tonight.
>
>IMPORTANT NOTICE: I am using Bios revision F.18A as of 2 Jan 03. Previous
>release might not work.
>
>What is working:
>
>- batteries (BAT0  BAT1)
>- ac_adapter (ACAD)
>- button (lid  power  sleep)
>- embedded_controller (C0D0)
>- fan (I have 4 of them: C1D9  C1DA  C1DB  C1DC)
>- power_resources (C0CF  C141  C155  C159  C15D  C166  C1D5  C1D6  C1D7  C1D8)
>- processor (C000)
>- thermal_zone (I have three of them, first one is CPU, TZ1  TZ2  TZ3)
>- Fn F7/F8 work (panel brightness)
>- pressing the lid button turns the screen off as expected
>
>What can be improved
>
>- sleep states: echo 5 works (shutdown), echo 4 works (it invokes swsusp)
>                other states do nothing
>- CPU: (*) I can change throttling state fine
>       (*) performance always report P0, however I checked the following:
>           turning AC/battery produced the desired effects (P1 when on battery)
>           even if it is not reported in /proc/acpi
>       (*) I can swicth to P1 when on AC with "echo 1:0 > limit" (always
>           doesn't appear in proc/acpi), but "echo 0:0 > limit" does not switch
>           back to P0. In order to switch back, I turn AC off for a second and
>           then put it back, so that the BIOS does the job for me.
>- volume control buttons: are they acpi-related?
>
>I hope this will help somebody.
>
>Daniele
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by:ThinkGeek
>Welcome to geek heaven.
>http://thinkgeek.com/sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>  
>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
