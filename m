From: Michael Grigoriev <mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org>
Subject: Re: Standby (S1) does not work
Date: Mon, 07 Jun 2004 00:34:32 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.06.07.00.34.31.1417@luminal.org>
References: <pan.2004.06.06.15.05.09.196978@luminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

On Sun, 06 Jun 2004 15:05:10 +0000, Michael Grigoriev wrote:
> In possibly related news, I noticed this abnormality:
> 
> # cat /sys/power/state
> standby mem disk
> 
> # cat /proc/acpi/sleep
> S0 S3 S4 S4bios S5
> 
> Notice that proc does not even list S1!

Further research shows that S1 does in fact not exist. _S1 is not defined
in the DSDT. I thought S1 is like the most basic ACPI mode and everybody
would have it, no? Do you think that it is actually not supported by
hardware, or is it just that the didn't bother adding it to the DSDT?

Would it be a safe experiment to try throwing something like 

    Name (\_S1, Package (0x03)
    {
        0x02, 
        0x02, 
        0x00
    })

into the DSDT?

Has anybody tried anything like this? :)

Thanks in advance.

-- 
Have fun,                                As the moment elapsed
Michael "mag" Grigoriev                We walked in slowmotion
mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org                               Denying the tide
http://www.luminal.org                 We'll find our devotion



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
