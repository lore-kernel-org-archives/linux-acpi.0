From: Mark A Russell <m.a.russell-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: ACPI CPU Usage problems ( events process taking near 100%
 )
Date: Sat, 10 Jan 2004 10:20:40 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40003468.8020409@comcast.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C7A@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C7A-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The temperature is reporting in around 70C.  This makes perfect sense 
because the events/0 process is taking 100% of the cpu causing it to 
heat up.  Solve the events/0 process problem and te fan problem should 
be solved.

The only oddball thing I have noticed in the logs is this set of messages:

[Fri Jan 9 20:53:17 2004] received event "battery BAT1 00000080 00000001"
[Fri Jan 9 20:53:17 2004] executing action "/etc/acpi/default.sh battery 
BAT1 00000080 00000001"
[Fri Jan 9 20:53:17 2004] BEGIN HANDLER MESSAGES
[Fri Jan 9 20:53:17 2004] END HANDLER MESSAGES
[Fri Jan 9 20:53:17 2004] action exited with status 0
[Fri Jan 9 20:53:17 2004] completed event "battery BAT1 00000080 00000001"

This set of message repeats every 20-20 seconds so I'm guessing this is 
an indicator of the problem.  I have tried pulling the battery out and 
just running on ac and these messages still show up.  Let me know if 
there is anything else that would help debug the problem.

Mark

Yu, Luming wrote:

>Fan going crazy means your laptop is in Active-cooling mode.
>What's the temperature in your laptop's thermal zone?
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IBM Linux Tutorials.
>Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
>Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
>Click now! http://ads.osdn.com/?ad_id78&alloc_id371&op=click
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
