From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Centrino question
Date: Sun, 23 May 2004 17:33:04 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BAY16-F76SQV6cerTPS0003d004@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: neurowork-GANU6spQydw@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Windows will use throttling to save on battery, when you are using the Max 
Battery policy, and power is unplugged.
Check the following link, where MS explains the policies in XP:
http://www.microsoft.com/whdc/system/pnppwr/powermgmt/ProcPerfCtrl.mspx


>From: Cyril Wattebled <neurowork-GANU6spQydw@public.gmane.org>
>....
>Yes, I have already asked around why this happends. Windows slows the 
>processor
>down to 200 mhz when unplugged and down to 600 mhz when plugged. Windows
>behaves just like linux with the AC power on but when on battery, it 
>manages
>to slow it down to 200mhz. This allows the laptop to last more than on 
>linux
>and also, the temperature of the overall laptop is cooler (which is really 
>more
>confortable).
>It seems that Windows is using some kind of clock modulation along with the
>enhanced speedstep. I'm not sure about that but, I was told that it should 
>be
>something like it. (cf cpufreq mailing list, thread called "Pentium M 
>minimum
>clock modulation").

_________________________________________________________________
MSN Messenger: instale grátis e converse com seus amigos. 
http://messenger.msn.com.br



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
