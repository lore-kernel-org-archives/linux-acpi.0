From: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Subject: Re: Toshiba 1905S303: update
Date: Tue, 23 Dec 2003 13:49:57 -0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FE86425.5000904@techisa.srv.br>
References: <3ACA40606221794F80A5670F0AF15F8401720C2C@PDSMSX403.ccr.corp.intel.com>
Reply-To: erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C2C-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yu, Luming escreveu:

>>Updating on my problem with Fn-F5 (switch video out) hanging the machine...
>>    
>>
>
>When did you start to have this kind of problem?
>
>  
>
>>I recompiled the latest known kernel working for me (2.4.21-013mdk,
>>shipped with Mandrake 9.1) with ACPI debug, and the current DSDT table
>>I'm using. I do see "QUERY_1C" messages with this kernel on
>>/var/log/messages, whereas with a newer kernel I do not (the machine
>>hangs first...).
>>    
>>
>
>It sounds like a regression. To let me better understand your problem, please file any
>useful thing on bugzilla.kernel.org
>
>--Luming
>
>  
>
I just created bug #1735 on bugzilla to deal with this. Please take a look at it:

http://bugme.osdl.org/show_bug.cgi?id=1735

I also posted the relevant dmesg and system log files from working and non-working situations, plus my current DSDT and the original DSDT.


-- 

-- Erico Mendonca
Techisa do Brasil





-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
