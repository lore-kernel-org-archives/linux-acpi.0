From: Uwe Maier <umaier-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi_power_off
Date: Sun, 06 Jun 2004 16:06:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C324EE.6080602@gmx.de>
References: <HYSPW8$1309D80CA450E8BBB2E00C5851F6C4B0@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <HYSPW8$1309D80CA450E8BBB2E00C5851F6C4B0-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi mailing acpi mailing <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Phil,
I've seen this problem with sysvinit 2.85-16 on unstable too.
I think it has nothing to do with ACPI but with the debian package. It's 
sufficient to downgrade to 2.8-15 to have a proper power off again.

Regards,
uwe


fil.tri-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org wrote:

>I have a debian system with kernel 2.6.6.
>I have configured all correctly: thermal, processor and others are ok, but 
>yesterday I have installed a ndiswrapper package (for install driver of my wireless card)
>and now my system when I call "poweroff" don't tun off and remain in "System halted".
>I have noticed that the kernel don't call the function "acpi_power_off", that turn off the system.
>I tried to remove ndiswrapper package but don't work.
>
>Best regards,
>
>Phil
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the new InstallShield X.
>>From Windows to Linux, servers to mobile, InstallShield X is the one
>installation-authoring solution that does it all. Learn more and
>evaluate today! http://www.installshield.com/Dev2Dev/0504
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
